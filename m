Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQL0KiN>; Wed, 27 Dec 2000 05:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbQL0KiD>; Wed, 27 Dec 2000 05:38:03 -0500
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:56808 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id <S129610AbQL0Khx>; Wed, 27 Dec 2000 05:37:53 -0500
Date: Wed, 27 Dec 2000 11:07:22 +0100 (CET)
From: Nils Philippsen <nils@fht-esslingen.de>
Reply-To: <nils@fht-esslingen.de>
To: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Rik Faith <faith@valinux.com>,
        Dri-devel <Dri-devel@lists.sourceforge.net>
Subject: Re: test13-preX: DRM (tdfx.o) unresolved symbols fixed?
In-Reply-To: <00122702540800.15395@SunWave1>
Message-ID: <Pine.LNX.4.30.0012270951360.21331-100000@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Wed, 27 Dec 2000, Dieter [iso-8859-1] Nützel wrote:

> I got this since test13-pre1 (pre4, now):
>
> SunWave1>depmod -e
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.0-test13-pre4/kernel/drivers/char/drm/tdfx.o

[snipped]

> Something missing in the 'new' drm/Makefile?

>From the test13-pre4 patch, the only difference I can see is that shared code
is now in drmlib.a instead of the object files being linked individually for
each drm module.

If I do `nm tdfx.o|grep printk`, with test12 I get only this:

         U printk_R1b7d4074

with test13-pre4 on my home machine, I get the mangled symbol name plus a
non-mangled one, both unresolved, maybe that causes problems.

Nils
-- 
 Nils Philippsen / Berliner Straße 39 / D-71229 Leonberg // +49.7152.209647
nils@wombat.dialup.fht-esslingen.de / nils@fht-esslingen.de / nils@redhat.de
   The use of COBOL cripples the mind; its teaching should, therefore, be
   regarded as a criminal offence.                  -- Edsger W. Dijkstra


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
