Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSLYU1S>; Wed, 25 Dec 2002 15:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSLYU1S>; Wed, 25 Dec 2002 15:27:18 -0500
Received: from zork.zork.net ([66.92.188.166]:26093 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S261292AbSLYU1S>;
	Wed, 25 Dec 2002 15:27:18 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG???] EXT3FS+VM86+/dev/mem+pthread=segfault
References: <20021225215452.020129b0.nickols_k@mail.ru>
	<20021225202406.GB18790@lisa>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: DISCLOSURE OF TRADE SECRET(S), DENIAL
 OF THE ANTECEDENT
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Wed, 25 Dec 2002 20:35:31 +0000
In-Reply-To: <20021225202406.GB18790@lisa> (Marc Schiffbauer's message of
 "Wed, 25 Dec 2002 21:24:06 +0100")
Message-ID: <6uel85j0q4.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Marc Schiffbauer quotation:

> * Nick Kurshev schrieb am 25.12.02 um 19:54 Uhr:
>> Btw, does there exists any way to convert ext3fs to ext2fs safely?
>> 
>
> You may try to "mount -t ext2fs" it.

s/ext2fs/ext2/

If you wish to *permanently* convert an ext3 volume to ext2, I believe
the way to do it is to first umount it and then run:

# tune2fs -O ^has_journal /dev/xxx
# fsck -f /dev/xxx

where /dev/xxx is the volume in question.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
