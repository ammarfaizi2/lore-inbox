Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268008AbRGVRsW>; Sun, 22 Jul 2001 13:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268009AbRGVRsM>; Sun, 22 Jul 2001 13:48:12 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:780 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S268008AbRGVRr7>; Sun, 22 Jul 2001 13:47:59 -0400
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: MO-Drive under 2.4.7 usinf vfat
In-Reply-To: <3B5AE813.658ADC66@torque.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 23 Jul 2001 02:47:24 +0900
In-Reply-To: <3B5AE813.658ADC66@torque.net>
Message-ID: <87itgkdff7.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

Douglas Gilbert <dougg@torque.net> writes:

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> > Is the capacity of your MO disk more than 640M?
> 
> No, the capacity is 635600896 bytes.

[...]

> 
> > Perhaps, your MO disk will have the `ls' of a value smaller 
> > than 2048.
> Yes, ls=512 .
> 
> > Logical sector size smaller than device sector size cannot
> > be handled with FAT of 2.4 series.
> 
> Great. When will that be fixed (Jens?) ? If not, can we get 
> a more civilized response than the current oops?

The cause of this problem is me, and I think that it is the bug.
How should this problem be solved? I think that it is either of the
following.

    1) logical sector size smaller than device sector size isn't
       supported. (and output the message)

    2) read a file data via block buffer (like FAT of 2.2 series).

    3) other (drivers/block/loop.c?)

Please comment.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

