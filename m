Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWCIVQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWCIVQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbWCIVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:16:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42963 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751613AbWCIVQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:16:11 -0500
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for
	2.6.16-rc5
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net,
       Ben Collins <ben.collins@ubuntu.com>
In-Reply-To: <20060309204639.GA453@redhat.com>
References: <20060306223545.GA20885@kroah.com>
	 <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de>
	 <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
	 <20060308231851.GA26666@suse.de>
	 <Pine.LNX.4.64.0603081528040.32577@g5.osdl.org>
	 <20060309184010.GA4639@irc.pl>
	 <Pine.LNX.4.64.0603091137180.18022@g5.osdl.org>
	 <1141936671.2883.33.camel@laptopd505.fenrus.org>
	 <20060309204639.GA453@redhat.com>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 22:15:59 +0100
Message-Id: <1141938960.2883.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:46 -0500, Dave Jones wrote:
> On Thu, Mar 09, 2006 at 09:37:50PM +0100, Arjan van de Ven wrote:
>  > On Thu, 2006-03-09 at 11:49 -0800, Linus Torvalds wrote:
>  > > 
>  > > On Thu, 9 Mar 2006, Tomasz Torcz wrote:
>  > > > > 
>  > > > >   "Fedora rawhide kernel stopped booting for a bunch of people, all with 
>  > > > >    686-SMP boxes. I saw it myself too, it hung just after the 'write 
>  > > > >    protecting kernel rodata'.
>  > > > > 
>  > > > 
>  > > >   Ubuntu has similar problem:
>  > > > https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/29601
>  > > >  I believe Ubuntu's 2.6.15 source is vanilla+git patches.
>  > > 
>  > > Interesting. He also apparently boots with "noapic nolapic" on the "386" 
>  > > kernel, but not the "686" kernel.
>  >
>  > hmm curious; I wonder if the "weird" (as in, Arjan considers it a stupid
>  > idea and broken) "enable APIC on UP but not really" patch is at fault
>  > here, which isn't in mainline....
> 
> Not present in the Fedora kernels any more, and this bug has been seen in
> ones without it.

ok then that's ruled out... (I assume apics are entirely off now for at
least one build that has seen this behavior)

