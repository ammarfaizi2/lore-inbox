Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTFDISY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 04:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbTFDISY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 04:18:24 -0400
Received: from aneto.able.es ([212.97.163.22]:30951 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263163AbTFDISX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 04:18:23 -0400
Date: Wed, 4 Jun 2003 10:31:50 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Daniel.A.Christian@NASA.gov
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc7 SMP module unresolved symbols
Message-ID: <20030604083150.GA2770@werewolf.able.es>
References: <200306031728.41982.Daniel.A.Christian@NASA.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200306031728.41982.Daniel.A.Christian@NASA.gov>; from Daniel.A.Christian@NASA.gov on Wed, Jun 04, 2003 at 02:28:41 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.04, Dan Christian wrote:
> I can build a 2.4.21-rc7 Athlon single processor kernel and modules 
> without problem.
> 
> When I enable SMP, most (but not all) modules have unresolved symbols.  
> This is basic stuff like prink and kmalloc.  I've tried both with and 
> without symbol versioning.
> 
> The build line was:
> make clean && make dep && make bzImage && make modules && make 
> modules_install
> 

You're missing a make install, I think ( at least this is what I do,
perhaps something is redundant:

make clean
make dep
make bzImage
make install  <<<<<<<<<<<<<<<<
make modules
make modules_install

Wthout the make install yu don't have nor the new kernel nor the System.map
in /boot.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc7-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
