Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbSJGHm3>; Mon, 7 Oct 2002 03:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbSJGHm3>; Mon, 7 Oct 2002 03:42:29 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:43651 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S262911AbSJGHm2> convert rfc822-to-8bit;
	Mon, 7 Oct 2002 03:42:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: LILO probs
Date: Mon, 7 Oct 2002 09:48:17 +0200
User-Agent: KMail/1.4.1
References: <200210062159.18958.roy@karlsbakk.net> <02100623372401.00238@7ixe4>
In-Reply-To: <02100623372401.00238@7ixe4>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210070948.17169.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please see below.
Rene (below) have tried to help me out here, but I still can't boot. / is on 
hda5 and /boot is on hda1.

Any suggestions?

thanks

roy

On Sunday 06 October 2002 23:37, Rene Herman wrote:
> On Sunday 06 October 2002 21:59, you wrot
>
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
>
> Looks perfectly normal. That "1023" is simply because the cylinder field is
> held in a 10-bit field, giving the famous 1024 cylinder-limit. With LBA
> addressing all partitions are created like this.
>
> I can see absolutely no reason why things wouldn't work. If you use lba32,
> you should be able to have /boot anywhere on the disk. /dev/hda1 falls
> completely within the 1024 limit, so if you put /boot there, you should
> even be able to boot *without* lba32. Example minimal /etc/lilo.conf:
>
> ===
> boot=/dev/hda
> lba32
> prompt
>
> image=/boot/vmlinuz
> 	root=/dev/root
> 	label=linux
> ===
>
> You do have boot=/dev/hda don't you? Not /dev/hda1 or something silly like
> that?
>
> Rene.

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

