Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136471AbRD3HjV>; Mon, 30 Apr 2001 03:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136472AbRD3HjK>; Mon, 30 Apr 2001 03:39:10 -0400
Received: from hera.cwi.nl ([192.16.191.8]:46997 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S136471AbRD3HjD>;
	Mon, 30 Apr 2001 03:39:03 -0400
Date: Mon, 30 Apr 2001 09:38:46 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200104300738.JAA40861.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, mdharm-kernel@one-eyed-alien.net
Subject: Re: Dane-Elec PhotoMate Combo
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        mailhot@enst.fr, markus@schlup.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> This config option is considered so immature that it's not ready for
>>> kernel config, even as an EXPERIMENTAL.  Use it at your own risk.

>> Of course. But the choice is simple. Without it, one has a non-functional
>> device. With it, one has a device that works beautifully.

> I would seriously argue with the "works beautifully" part of that.
> The DPCM code relies on the SDDR09 code, which is horrendously buggy.
> I can crash it at will with relatively simple operations.

Let me be more precise then.
The commands
	blockdev --rereadpt /dev/sdb
	mount /dev/sdb1 /f -t msdos
	mv /f/dcim/100mlt01/* .
	umount /f
copy the digital camera images written by a Minolta from a Compact Flash
card to the current directory and empty the card. This is the part that
works beautifully (since it works).

(One of these days I must look more at the rereadpt part of this.
After removing the card, I still have the partition /dev/sdb1,
which is an error.)

Andries
