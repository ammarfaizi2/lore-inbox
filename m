Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264637AbSKYPJa>; Mon, 25 Nov 2002 10:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264890AbSKYPJa>; Mon, 25 Nov 2002 10:09:30 -0500
Received: from elin.scali.no ([62.70.89.10]:34820 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S264637AbSKYPJa>;
	Mon, 25 Nov 2002 10:09:30 -0500
Date: Mon, 25 Nov 2002 16:18:21 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>
cc: linux-kernel@vger.kernel.org, Manish Lachwani <manish@zambeel.com>,
       <mingo@redhat.com>
Subject: Re: i7500 and IRQ assignment
In-Reply-To: <200211251516.10261.gabrielli@roma2.infn.it>
Message-ID: <Pine.LNX.4.44.0211251615330.5004-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Emiliano Gabrielli wrote:

> On 19:25, venerdì 22 novembre 2002, Manish Lachwani wrote:
> > I experienced the same problem with Supermicro and Intel E7500 board. Look
> > on
> >
> > http://sourceforge.net/projects/lse
> >
> > for the apic routing patch. This patch, when applied, will solve the issue
> 
> uhmm I have tried to apply it against the 2.4.18-18.7.1xsmp by RH, but of sure 
> it gave conflicts... I wan not able to resolve them by hand, in paticular I 
> can't find the funcion/macro "processor()"...
> 
> Has this patch been applied agaist a more recent kernel yet ?!? 2.4.18 is quit 
> out of date, expecially for the APIC-related problems...
> 
> My final goal is only to have an IRQ assigne to my custom PCI device by the 
> SuperMicro P4DP6 MB (e7500), with HT enabled
> 

2.4.20-rc2 or -rc3 work fine on my E7500 boards. I've appiled the 
irqbalance patch from Ingo Molnar though. It gives me better interrupt 
latency compared to the APIC routing patch (with GbE it is ~10us faster on 
ping-pong/2 tests).

Regards,
 -- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

