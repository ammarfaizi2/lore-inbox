Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbSIXIDo>; Tue, 24 Sep 2002 04:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbSIXIDo>; Tue, 24 Sep 2002 04:03:44 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:33796 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261608AbSIXIDm>; Tue, 24 Sep 2002 04:03:42 -0400
Message-Id: <200209240804.g8O84Kp24759@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Larry Kessler <kessler@us.ibm.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
Date: Tue, 24 Sep 2002 10:58:45 -0200
X-Mailer: KMail [version 1.3.2]
References: <3D8FEEBE.F471CA10@us.ibm.com>
In-Reply-To: <3D8FEEBE.F471CA10@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 September 2002 02:49, Larry Kessler wrote:
> Jeff Garzik wrote:
> > >       }
> > >       if (!request_mem_region(pci_resource_start(pdev, 0),
> > >                       pci_resource_len(pdev, 0), "eepro100")) {
> > > -             printk (KERN_ERR "eepro100: cannot reserve MMIO
> > > region\n"); +             pci_problem(LOG_ERR, pdev, "eepro100: cannot
> > > reserve MMIO region");
> >
> > bloat, no advantage over printk
>
> the advantage is that the string, which means plenty to the developer, but
> possibly much less to a Sys Admin, can be replaced with a more descriptive
> message, in the local language, by editing the formatting template in
> user-space.  Since the printk messages were mapped directly over to the
> problem macros, then the issue here I think is how useful (or not) the
> info. is more so than what interface is used.

The problem is that printks are very easy, people won't easily switch
to any other thing if it is hard to understand/use. If you can provide
such easy interface, then ok.

Regarding translation problem: it makes life easier to admins, i.e. you
enable Linux to be used by more stupid admins :-).

This race could not be won: Universe can always produce more remarkable
idiots. Next time they will ask you "what is eepro100?" and if you say
"it's a NIC, if you have intermittent link indicator problem try to reseat
network cord..." they will ask "what is NIC and how to reseat the cord?"
(btw, they will ask that in their native language). 8-(

Maybe requiring admins to know basic English is not that bad?
--
vda
