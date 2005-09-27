Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbVI0Ny4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbVI0Ny4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVI0Ny4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:54:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48084 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964949AbVI0Nyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:54:55 -0400
Subject: Re: [Bonding-devel] Re: [PATCH] channel bonding: add support for
	device-indexed parameters
From: Eric Paris <eparis@redhat.com>
To: Florin Malita <fmalita@gmail.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, nsxfreddy@gmail.com, akpm@osdl.org,
       davem@davemloft.net, ctindel@users.sourceforge.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       bonding-devel@lists.sourceforge.net
In-Reply-To: <20050927094055.7953a832.fmalita@gmail.com>
References: <20050927012444.be5d5311.fmalita@gmail.com>
	 <200509270711.j8R7BunP014387@death.nxdomain.ibm.com>
	 <20050927094055.7953a832.fmalita@gmail.com>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 09:54:29 -0400
Message-Id: <1127829269.4560.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It dos work with RHEL3.  In modules.conf you just need

alias bond0 bonding
options bond0 -o bonding0 
alias bond1 bonding
options bond1 -o bonding1

You can add your mode and mii_mon and such on the options lines.  It
does work I've used it.

-Eric


On Tue, 2005-09-27 at 09:40 -0400, Florin Malita wrote:
> On Tue, 27 Sep 2005 00:11:56 -0700
> Jay Vosburgh <fubar@us.ibm.com> wrote:
> > 
> > Florin Malita <fmalita@gmail.com> wrote:
> > [...]
> > >How can you load a module multiple times on _any_ distro?
> > 
> > 	modprobe -obond0 bonding mode=your-favorite-mode
> > 	modprobe -obond1 bonding mode=some-other-mode
> > 
> > 	and so on.  This is in the modprobe man page, and is described
> > in the bonding documentation (found in the kernel documentation or at
> > http://sourceforge.net/projects/bonding).  It is admittedly somewhat
> > grotty, but it works.  
> 
> OK, I see this capability has been in module-init-tools since the 0.8
> days. Doesn't apply to any 2.4/modutils based system tough.
> 
> > 
> > >Not being able to set a (different) preferred
> > >interface/primary for each bond device makes it unacceptable for
> > >deployment in our environment.
> > 
> > 	How are you configuring bonding?  The current SuSE distros, for
> > example, will do the multiple module load stuff automatically in the
> > sysconfig scripts.  This is described in the current bonding
> > documentation.
> 
> Our systems are RHEL3 based so unfortunately the naming trick above
> doesn't work. 
> 
> But it does work on RHEL4 so admittedly, having this workaround
> available for recent distros removes the urgency for a fix.
> 
> Thanks
> Florin
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server. 
> Download it for free - -and be entered to win a 42" plasma tv or your very
> own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bonding-devel mailing list
> Bonding-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bonding-devel

