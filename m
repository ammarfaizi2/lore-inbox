Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbVJUUiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbVJUUiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 16:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbVJUUiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 16:38:11 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:15499 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S965155AbVJUUiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 16:38:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Marc Perkel <marc@perkel.com>
Subject: Re: sata_nv + SMP = broken?
Date: Fri, 21 Oct 2005 22:38:25 +0200
User-Agent: KMail/1.8.2
Cc: Vladimir Lazarenko <vlad@lazarenko.net>, linux-kernel@vger.kernel.org
References: <4358C417.9000608@lazarenko.net> <4359144F.8090504@perkel.com>
In-Reply-To: <4359144F.8090504@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510212238.25614.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 21 of October 2005 18:16, Marc Perkel wrote:
> 
> Vladimir Lazarenko wrote:
> 
> > Hello,
> >
> > Yesterday I've tried launching various kernels on Ahtlon64 Dual-core 
> > X2 3800+ with MSI Neo4 Platinum SLI motherboard.
> >
> > The results were a total catastrophica failure. As soon as I enable 
> > SMP in the kernel, the sata driver would randomly hang after a bit of 
> > disk activity.
> >
> > Whenever apic is enabled, the system won't even be able to boot up 
> > completely, and will hang VERY soon. Whenever I disable apic, the 
> > system is able to bootup, but when the software mirror that I use will 
> > try to resync for 2-3-10 mins, it will throw up a message and freeze 
> > again.
> >
> > Whenever I disable apic AND lapic, the system is able to bootup AND 
> > work, however after same 5-10 minutes it start spitting messages, 
> > which are somewhat different thou and don't hang the system completely 
> > but render it rather unusable anyway.
> >
> > As soon as I disable SMP - everything works like a charm.
> >
> 
> For what it's worth I too have seen this same problem. It happens when I 
> use the stock Fedora kernels but not my custom compiled kernel. I'm not 
> sure what I compiled differently but at the time I thought that 
> something in the new kernel fixed it.

I only use kernel.org kernels, so perhaps there's a problem with the Fedora
kernel.

> I too am running an Athlon X2 using sata_nv. I have an ASUS motherboard. 
> But what I noticed was that the problem went away if I used 2 gigs of 
> ram instead of 4 gigs. When you use the whole 4 gigs there is some 
> memory mapping going on and I thought perhaps the problem was related to 
> the sata_nv not liking the memory mapped over the 4gig barrier.

That's possible.  Unfortunately I cannot verify this, since there are 2GB of
RAM in my box.

I remeber someone having a problem with sata_nv DMAing over 2GB of RAM,
so there may be something wrong with it.

Greetings,
Rafael
