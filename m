Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbRBHXc2>; Thu, 8 Feb 2001 18:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRBHXcR>; Thu, 8 Feb 2001 18:32:17 -0500
Received: from janus.cypress.com ([157.95.1.1]:37829 "EHLO janus.cypress.com")
	by vger.kernel.org with ESMTP id <S129042AbRBHXcE>;
	Thu, 8 Feb 2001 18:32:04 -0500
Message-ID: <3A832C6C.F17B11B5@cypress.com>
Date: Thu, 08 Feb 2001 17:31:56 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: spelling of disc (disk) in /devfs
In-Reply-To: <6lah7t4f685qo3igk679ocdo2obfhd9lvg@4ax.com> <20010201034217.A550@foozle.turbogeek.org> <20010201042813.C27725@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Jeremy M. Dolan]
> > Disk is spelled 'disk' except for Compact Disc and Digital Versatile
> > Disc. If it wasn't 3:30 in the morning, a patch would be attached.
> 
> It wouldn't do any good.  Many months ago, Ted Ts'o pleaded with
> Richard Gooch (devfs author, from Australia) to switch to the American
> spelling of the word, for consistency with the rest of the kernel, and
> nothing came of it.  At this point you may as well consider
> '/dev/discs' an "interface set in stone".  (Come on, do *you* want to
> explain to thousands of people why their /etc/fstab suddenly broke?)

Better still, follow the lead from other Solaris and HP-UX.

/dev/dsk/* block access for hard drives
/dev/rdsk/* char access for hard drives
/dev/diskette block access for floppy drives
/dev/rdiskette char access for floppy drives
/dev/rscsi/* char access for raw scsi (replace /dev/sg* )

Since linux currently doesn't have char access to drives,
rdsk/rdiskette would be ignored untill it is implemented
and needed.

My $0.02

	-Thomas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
