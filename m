Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbTDRLHj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 07:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbTDRLHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 07:07:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23454 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263020AbTDRLHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 07:07:39 -0400
Date: Fri, 18 Apr 2003 12:19:35 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Kernel<->Userspace API issue
Message-ID: <20030418111934.GA669@gallifrey>
References: <20030418092755.A25177@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030418092755.A25177@flint.arm.linux.org.uk>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.5.66 (i686)
X-Uptime: 12:16:15 up 16 min,  1 user,  load average: 0.00, 0.20, 0.29
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King (rmk@arm.linux.org.uk) wrote:
> I think this is a case in point that our policy on "userspace must not
> include kernel headers" is completely wrong when it comes to user
> space interfaces.  I believe we need is a clear set of defined user
> space interface headers which contain the definition of structures and
> numbers shared between user space and kernel space.  ie, include/abi
> or some such.

Yes!!! For those of us who need (for various reasons) to work below the
level of GLibc it is currently a nightmare trying to pick apart the
calling conventions for each syscall.

Of course it is not only syscalls; but also signal numbering and other
constants.

(Oh bonus points for sharing as much of this between architectures as
possible and just having the differences in architecture specific
files).

Dave

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
