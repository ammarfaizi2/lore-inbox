Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274524AbRJAD4L>; Sun, 30 Sep 2001 23:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274529AbRJAD4B>; Sun, 30 Sep 2001 23:56:01 -0400
Received: from unthought.net ([212.97.129.24]:64143 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S274524AbRJADzv>;
	Sun, 30 Sep 2001 23:55:51 -0400
Date: Mon, 1 Oct 2001 05:56:19 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Evan Harris <eharris@puremagic.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: RAID5: mkraid --force /dev/md0 doesn't work properly
Message-ID: <20011001055619.B24589@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Evan Harris <eharris@puremagic.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011001024130.A24589@unthought.net> <Pine.LNX.4.33.0109301944430.2459-100000@kinison.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0109301944430.2459-100000@kinison.puremagic.com>; from eharris@puremagic.com on Sun, Sep 30, 2001 at 07:51:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2001 at 07:51:25PM -0500, Evan Harris wrote:
> 
> Thanks for the fast reply!
> 
> I'm not sure I understand why drive 5 should be failed.  It is one of the
> four disks with the most recently correct superblocks.  The disk with the
> oldest superblock is #1.  Can you point me to documentation which explains
> this better?  I'm a little afraid of doing that without reading more on it,
> since it seems to mark yet another of the 4 remaining "good" drives as
> "bad".

Oh, sorry,   of course the oldest disk should be marked as failed.

But the way you mark a disk failed is to replace "raid-disk" with "failed-disk".

What you did in your configuration was to say that sde1 was disk 1, and sdi1 was
disk 5 *AND* disk 1 *AND* it was failed.

Replace "raid-disk" with "failed-disk" for the device that you want to mark
as failed.  Don't touch the numbers.

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
