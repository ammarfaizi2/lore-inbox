Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288719AbSADS7i>; Fri, 4 Jan 2002 13:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288689AbSADS72>; Fri, 4 Jan 2002 13:59:28 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:53492 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S288712AbSADS7S>; Fri, 4 Jan 2002 13:59:18 -0500
Date: Fri, 4 Jan 2002 19:41:34 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: David Weinehall <tao@acc.umu.se>
cc: Lionel Bouton <Lionel.Bouton@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        BALBIR SINGH <balbir.singh@wipro.com>, esr@thyrsus.com,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020103231723.Z5235@khan.acc.umu.se>
Message-ID: <Pine.GSO.3.96.1020104193143.829C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, David Weinehall wrote:

> At least MCA and NuBus can be autodetected, and I'm fairly confident
> the people behind the VME-bus and TurboChannel weren't stupid either,
> so those can probably be autodetected and probed too.

 The TURBOchannel is currently DECstation-only, so it can be easily
deduced by the system type from /proc/cpuinfo (Alphas have it there as
well, so if the Alpha port is ever finished there should be no problem). 
You can have a Qbus-TURBOchannel bridge on certain VAX systems, so it
would have to be detected separately once (if) supported.

 I'm not sure if it's worthwhile to implement /proc/bus/tc or whatever as
there is likely nothing in the userland to need that info ever and for
diagnostics the firmware and the startup log are sufficient.  If useful,
it would be trivial to code, though.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

