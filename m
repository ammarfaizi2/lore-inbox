Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbTCCPJO>; Mon, 3 Mar 2003 10:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTCCPJN>; Mon, 3 Mar 2003 10:09:13 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40091
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265470AbTCCPJN>; Mon, 3 Mar 2003 10:09:13 -0500
Subject: Re: Protecting processes from the OOM killer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303030845.00097.pollard@admin.navo.hpc.mil>
References: <3E5EB9A8.3010807@kegel.com>
	 <1046439618.16599.22.camel@irongate.swansea.linux.org.uk>
	 <3E5F8985.60606@kegel.com>  <200303030845.00097.pollard@admin.navo.hpc.mil>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046708617.6509.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 16:23:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 14:45, Jesse Pollard wrote:
> Shouldn't - the process the user tries to run will not be started since
> it must reserve the space first. malloc will fail immediately, allowing the
> process to handle the even gracefully and exit.
> 
> Anything else is a bug in the application.

The one case you can't cover cleanly in C is a stack grow exceeding memory
usage. At that point it requires a tiny bit of magic. You can do it, but 
the overcommit blocker has to armwave a little for the kernel and other
things so I've never seen it happen in a normal situation

