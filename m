Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262916AbSJGIUw>; Mon, 7 Oct 2002 04:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262917AbSJGIUw>; Mon, 7 Oct 2002 04:20:52 -0400
Received: from hacksaw.org ([216.41.5.170]:6240 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S262916AbSJGIUv>; Mon, 7 Oct 2002 04:20:51 -0400
Message-Id: <200210070826.g978QRhq007655@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.5 08/15/2002 with nmh-1.0.4
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: LILO probs 
In-reply-to: Your message of "Mon, 07 Oct 2002 10:12:12 +0200."
             <200210071012.12712.roy@karlsbakk.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Oct 2002 04:26:27 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Disk /dev/hda: 16 heads, 63 sectors, 38792 cylinders
> >
> > Nr AF  Hd Sec  Cyl  Hd Sec  Cyl    Start     Size ID
> >  1 80   1   1    0  15  63  609       63   614817 83
> >  2 00   0   1  610  15  63 1023   614880 10486224 83
> >  3 00  15  63 1023  15  63 1023 11101104  4194288 83
> >  4 00  15  63 1023  15  63 1023 15295392 23806944 0f
> >  5 00  15  63 1023  15  63 1023       63  2097585 83
> >  6 00  15  63 1023  15  63 1023       63  1048257 83
> >  7 00  15  63 1023  15  63 1023       63  1048257 82
> >  8 00  15  63 1023  15  63 1023       63 19612593 83

It's a very confusing table, but more importantly it seems to imply that 
/dev/hda{5,6,7,8} all start at cylinder 63, and end in a variety of places.

If this is an accurate representation of the partition table on this disk, I 
would suggest you recover what you can from it, and start over.

Better would be to have a look at the partition table with something that can 
fix it, like fdisk, sfdisk or parted. Example:

sfdisk -l /dev/hda


-- 
If in doubt, consult tradition.
If still in doubt, consult your experience.
If still in doubt, consult your body.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


