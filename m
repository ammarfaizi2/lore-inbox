Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129135AbRBOONR>; Thu, 15 Feb 2001 09:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129150AbRBOONI>; Thu, 15 Feb 2001 09:13:08 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:57001 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129135AbRBOOM6>; Thu, 15 Feb 2001 09:12:58 -0500
Date: Thu, 15 Feb 2001 12:47:33 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David D.W. Downey" <pgpkeys@hislinuxbox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: MP-Table mappings
In-Reply-To: <E14T9T3-00067H-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1010215122831.2905B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Alan Cox wrote:

> > In my dmesg I'm getting duplicate table reservations.
> 
> Just a crap bios

 That's unrelated -- duplicate reservations are due to the MP table being
located in memory areas marked as "reserved" (ROM, ususally) in the map. 
Thus the area is never freed in the first place and when smp_scan_config()
calls reserve_bootmem() for the pages a warning is issued.  Harmless,
indeed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

