Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVGVJm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVGVJm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 05:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVGVJm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 05:42:26 -0400
Received: from grerelbas02.net.external.hp.com ([192.6.111.86]:50091 "EHLO
	grerelbas02.bastion.europe.hp.com") by vger.kernel.org with ESMTP
	id S261466AbVGVJkE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 05:40:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: a 15 GB file on tmpfs
Date: Fri, 22 Jul 2005 11:39:56 +0200
Message-ID: <213219CA6232F94E989A9A5354135D2F093887@frqexc04.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: a 15 GB file on tmpfs
Thread-Index: AcWNL5XyQc3XvpcWTlOSnTeKBPN7xABcWqig
From: "Cabaniols, Sebastien" <sebastien.cabaniols@hp.com>
To: "Bastiaan Naber" <naber@inl.nl>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Jul 2005 09:39:57.0095 (UTC) FILETIME=[52435370:01C58EA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyway, if you buy a brand new server, you will find it difficult to get
a 32 bit architecture.

What I don't understand is why you want it to go into tmpfs, why don't
you let the pagecache do its job of putting the data in RAM where it is
needed ? 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Antonio Vargas
Sent: mercredi 20 juillet 2005 15:32
To: Erik Mouw
Cc: Bastiaan Naber; linux-kernel@vger.kernel.org
Subject: Re: a 15 GB file on tmpfs

On 7/20/05, Erik Mouw <erik@harddisk-recovery.com> wrote:
> On Wed, Jul 20, 2005 at 02:16:36PM +0200, Bastiaan Naber wrote:
> > I have a 15 GB file which I want to place in memory via tmpfs. I 
> > want to do this because I need to have this data accessible with a
very low seek time.
> 
> That should be no problem on a 64 bit architecture.
> 
> > I want to know if this is possible before spending 10,000 euros on a

> > machine that has 16 GB of memory.
> 
> If you want to spend that amount of money on memory anyway, the extra 
> cost for an AMD64 machine isn't that large.
> 
> > The machine we plan to buy is a HP Proliant Xeon machine and I want 
> > to run a
> > 32 bit linux kernel on it (the xeon we want doesn't have the 64-bit 
> > stuff
> > yet)
> 
> AFAIK you can't use a 15 GB tmpfs on i386 because large memory support

> is basically a hack to support multiple 4GB memory spaces (some VM 
> guru correct me if I'm wrong). Just get an Athlon64 machine and run a 
> 64 bit kernel on it. If compatibility is a problem, you can still run 
> a 32 bit
> i386 userland on an x86_64 kernel.
> 
> 
> Erik
> 
> --
> +-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
> | Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
> -

Bastian, Erik is dead-on on that one: go 64bit and forget all worries
about your 15GB filesize. Just don't forget to look not only x86-64
(intel or amd) but also itanium, ppc64 and s390 machines, you never know
about surprises!

--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
