Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129529AbQKWGLP>; Thu, 23 Nov 2000 01:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129586AbQKWGLE>; Thu, 23 Nov 2000 01:11:04 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:41479 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129529AbQKWGK4>; Thu, 23 Nov 2000 01:10:56 -0500
Date: Wed, 22 Nov 2000 23:40:47 -0600
To: Patrick van de Lageweg <patrick@bitwizard.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>
Subject: Re: [NEW DRIVER] firestream
Message-ID: <20001122234047.N2918@wire.cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0011221031340.995-100000@panoramix.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011221031340.995-100000@panoramix.bitwizard.nl>; from patrick@bitwizard.nl on Wed, Nov 22, 2000 at 10:32:23AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Patrick van de Lageweg]
> diff -u -r --new-file linux-2.4.0-test11.clean/drivers/atm/firestream.c linux-2.4.0-test11.fs50+atmrefcount/drivers/atm/firestream.c

Since you are submitting in the form of a source patch, you ought to
include the relevent bits of

  drivers/atm/Makefile
  drivers/atm/Config.in
  Documentation/Configure.help

> +int loopback = 0;
> +int fs_debug = 0;
> +struct fs_dev *fs_boards = NULL;

Aside from the 'static' issue already mentioned, these should be left
uninitialized.  ('gcc -fassume-bss-zero' would be nice, but then again
in userspace it rarely matters.)

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
