Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130741AbRBMHXt>; Tue, 13 Feb 2001 02:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130789AbRBMHXi>; Tue, 13 Feb 2001 02:23:38 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:58127 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130741AbRBMHXW>;
	Tue, 13 Feb 2001 02:23:22 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Ph. Marek" <marek@mail.bmlv.gv.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.[01] and duron - unresolved symbol _mmx_memcpy 
In-Reply-To: Your message of "Tue, 13 Feb 2001 07:47:33 BST."
             <3.0.6.32.20010213074733.00917210@pop3.bmlv.gv.at> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Feb 2001 18:23:13 +1100
Message-ID: <1151.982048993@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001 07:47:33 +0100, 
"Ph. Marek" <marek@mail.bmlv.gv.at> wrote:
>and the modules dependencies are not all set!
>make modules_install does not check for modules compilation - says
>"cp: file not found". I think that's because modules_install doesn't
>depend on the modules

Correct.  The current recursive makefile design means it is difficult
to get a definitive list of modules without excessive overhead.  So
modules_install assumes that you have compiled the modules already and
lets the 'cp' command fail.  The 2.5 Makefile redesign will get this
right.

>grep _mmx_memcpy /proc/ksyms
>	c01a4e20 _mmx_memcpy_R__ver__mmx_memcpy

Broken 2.4 makefile design.  http://www.tux.org/lkml/#s8-8
The 2.5 makefile redesign will kill this problem once and for all.

