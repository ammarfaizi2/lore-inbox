Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLSAcM>; Mon, 18 Dec 2000 19:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131249AbQLSAcC>; Mon, 18 Dec 2000 19:32:02 -0500
Received: from raven.toyota.com ([205.180.183.200]:13578 "EHLO
	raven.toyota.com") by vger.kernel.org with ESMTP id <S129431AbQLSAbt>;
	Mon, 18 Dec 2000 19:31:49 -0500
Message-ID: <3A3EA548.C7C81B85@toyota.com>
Date: Mon, 18 Dec 2000 16:01:12 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Olaf Titz <olaf@bigred.inka.de>
CC: linux-kernel@vger.kernel.org, Peter Samuelson <peter@cadcamlab.org>,
        Niels Kristian Bech Jensen <nkbj@image.dk>
Subject: Re: test13-pre3 woes
In-Reply-To: <Pine.LNX.4.30.0012180702380.16423-100000@hafnium.nkbj.dk> <3A3DD010.225F721C@pobox.com> <20001218031912.E3199@cadcamlab.org> <E1481G2-0006PE-00@g212.hadiko.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Titz wrote:

> In article <20001218031912.E3199@cadcamlab.org> you write:
> > [J Sloan]
> > >
> > > kernel/drivers/char/drm/tdfx.o: unresolved symbol remap_page_range
> >...
> > Those symbols are rather generic and rather important.  Sounds like a
> > generic module problem.  Do other modules load?

Yes, rtl8139, emu10k are loaded and working fine.

> Does your kernel use
> > MODVERSIONS?

Yes, I have CONFIG_MODVERSIONS=y

> (This module apparently doesn't.)  Are you using a recent
> > version of modutils?

# insmod -V
insmod version 2.3.21
...

> The most important question: Did you run "make dep" after doing the patch?

Yes, after the patch, it was, as always:

make clean
make menuconfig
make dep bzlilo modules modules_install

Same problem with 2.4.0-test13-pre3-ac1 on
my Linux workstation at the office, where the
token ring driver fails as well (olympic.o)

BTW, in my experience to date with kernels from
2.3.36 up to  2.4.0-test-12 it has all worked well.

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
