Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131625AbRAOViy>; Mon, 15 Jan 2001 16:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131673AbRAOVio>; Mon, 15 Jan 2001 16:38:44 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:42189 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131625AbRAOVig>; Mon, 15 Jan 2001 16:38:36 -0500
Date: Mon, 15 Jan 2001 22:38:28 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@transmeta.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386/setup.c cpuinfo notsc
In-Reply-To: <3A636231.B892D7D2@transmeta.com>
Message-ID: <Pine.GSO.3.96.1010115223503.16619b-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, H. Peter Anvin wrote:

> I would personally prefer to export the global flags separately from the
> per-CPU flags.  Not only is it more correct, it would help catch these
> kinds of bugs!!!

 That's what I am going to do.  Basically to recode cpu_has_* macros to
use global flags as that's the intuitive name and use a set of different
names for the SMP bootstrap code to access boot_cpu_data (possibly
boot_has_* or boot_cpu_has_*). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
