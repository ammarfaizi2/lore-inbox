Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130836AbQLRPXj>; Mon, 18 Dec 2000 10:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbQLRPXT>; Mon, 18 Dec 2000 10:23:19 -0500
Received: from pop.gmx.net ([194.221.183.20]:25902 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129260AbQLRPXI>;
	Mon, 18 Dec 2000 10:23:08 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
Date: Mon, 18 Dec 2000 15:49:20 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Mikael Djurfeldt <djurfeldt@nada.kth.se>, linux-kernel@vger.kernel.org
To: Peter Samuelson <peter@cadcamlab.org>, nbreun@gmx.de,
        torvalds@transmeta.com
In-Reply-To: <E147oeY-0006H7-00@mdj.nada.kth.se> <00121808022301.00937@nmb> <14909.48731.574210.724341@wire.cadcamlab.org>
In-Reply-To: <14909.48731.574210.724341@wire.cadcamlab.org>
Subject: Re: [PATCH] 2.4.0-test13-pre3: Makefile problem in drivers/video
MIME-Version: 1.0
Message-Id: <00121815492000.00832@nmb>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter, Alan,

thanks, this solved the problem - 2.4.0-test13pre3 is up 'n running ;)
BTW: Is it possible to shut off these "apic error on CPU0" messages."
Now I know that my board is not well designed, so what should these
messages help me? They blow up my /var/log/messages only...

kind regards
Norbert


On Monday 18 December 2000 08:35, Peter Samuelson wrote:
> [Norbert Breun]
>
> > The problem is, there should be a directory "media" under
> > /lib/modules/2.4.0-test12.old/kernel/drivers/ and this is missing in
> > test13pre2 and test13pre3. The modules are not built.
>
> Does this help?  I think it's right.
>
> Peter
>
> diff -urk.orig 2.4.0test13pre3/drivers/media/Makefile
> --- 2.4.0test13pre3/drivers/media/Makefile.orig	Sat Dec 16 06:18:16 2000
> +++ 2.4.0test13pre3/drivers/media/Makefile	Mon Dec 18 01:32:34 2000
> @@ -10,6 +10,7 @@
>  #
>
>  subdir-y     := video radio
> +subdir-m     := video radio
>
>  O_TARGET     := media.o
>  obj-y        := $(join $(subdir-y),$(subdir-y:%=/%.o))
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
