Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293249AbSCFGyn>; Wed, 6 Mar 2002 01:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293253AbSCFGyd>; Wed, 6 Mar 2002 01:54:33 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:16517
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S293249AbSCFGyX>; Wed, 6 Mar 2002 01:54:23 -0500
Date: Tue, 5 Mar 2002 22:53:58 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.5-dj3 - ide_modes.h
In-Reply-To: <20020306034355.A30476@suse.de>
Message-ID: <Pine.LNX.4.33.0203052245290.3642-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


in drivers/ide/ide_modes.h,

typedef ... ide_pio_timings_t;

is only defined #ifdef CONFIG_BLK_DEV_IDE_MODES.

But it is used in ide.c without any ifdefs around it, resulting in a
compile error.

In 2.5.5-dj2, this block was in ide_modes.h within the same #ifdef as the
typedef, but was moved by the -dj3 patch.

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8hb0LsYXoezDwaVARApQzAJ43FGatrKZU/Dht5bEgsRPwCYqNagCfUsMu
mjD6zffn1bgeJtyYjn6O3ng=
=mEOw
-----END PGP SIGNATURE-----

