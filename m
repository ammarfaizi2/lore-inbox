Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbQKRNo7>; Sat, 18 Nov 2000 08:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131237AbQKRNot>; Sat, 18 Nov 2000 08:44:49 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:38665 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129842AbQKRNol>;
	Sat, 18 Nov 2000 08:44:41 -0500
Date: Sat, 18 Nov 2000 14:14:26 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
Message-ID: <20001118141426.B23033@almesberger.net>
In-Reply-To: <20001117013157.A21329@almesberger.net> <slrn91b42n.fs.kraxel@bogomips.masq.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrn91b42n.fs.kraxel@bogomips.masq.in-berlin.de>; from kraxel@bytesex.org on Fri, Nov 17, 2000 at 08:08:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
> It simply did'nt work correctly and often used to misdetect
> random bt848 cards as either MIRO or Hauppauge (which where the first
> available cards).

Well, this means there's yet another mandatory __setup parameter :-(

Should it be called bttv_card or bt484_card (i.e. are there cases
where a user would want to override the card detection for non-848
bttv cards ?)

Likewise, in my radio patch, I called the parameter bt848_radio,
following the naming convention chosen for the config option. If
there are other chips, this may not be a good idea. Should I rename
this one to bttv_radio or are there no radios on non-848 chips ?
(I'll make a patch with both setup functions, since the
documentation changes overlap anyway.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
