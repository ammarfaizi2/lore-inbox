Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132471AbREHMpF>; Tue, 8 May 2001 08:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbREHMom>; Tue, 8 May 2001 08:44:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:18950 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S132425AbREHMnW>; Tue, 8 May 2001 08:43:22 -0400
Message-ID: <3AF7E9D0.E3097FA1@idb.hist.no>
Date: Tue, 08 May 2001 14:42:56 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre7 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        esr@thyrsus.com
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <E14wt0Q-00048P-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > But Alan's point is a good one.  There are _lots_ of cases you can't get away
> > with things like this, unless you get very fine grained.  In fact, it would
> > be much eaiser to do this seperately from the kernel.  Ie another,
> 
> There are also a lot of config options that are implied by your setup in
> an embedded enviromment but which you dont actually want because you didnt
> wire them
> 
> Second guessing is not ideal. As a 'make the default config nice' trick - great

This is easy without changing CML2.  Make another config option
for auto-enabling hardware you "probably have"

Rules of the form "X86 and PARPORT implies PARPORT_PC" can then
be transformed to "X86 and PARPORT and PROBABLE_HARDWARE implies
PARPORT_PC"

Those who want a nice & easy config may then turn PROBABLE_HARDWARE on.
Those who want tricks like using only nonstandard (hi-performance?)
serial
ports on their pc and save memory on skipping drivers for the built-in
stuff can do so by turning the probable setting off.

Helge Hafting
