Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbTA2LQt>; Wed, 29 Jan 2003 06:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbTA2LQt>; Wed, 29 Jan 2003 06:16:49 -0500
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:43442
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id <S265791AbTA2LQs>; Wed, 29 Jan 2003 06:16:48 -0500
X-Mailbox-Line: From galia@st-peter.stw.uni-erlangen.de  Wed Jan 29 12:26:08 2003
To: linux-xfs@oss.sgi.com
Subject: 2.4.20 + xfs +lvm2 =  raid0_make_request bug
Message-ID: <1043839567.3e37ba4fd327e@secure.st-peter.stw.uni-erlangen.de>
Date: Wed, 29 Jan 2003 12:26:07 +0100 (CET)
From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 172.17.17.181
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, a kind of repost 
useing lvm2(with lvm1 everything is working perfect for the last 6 months)
 when i try to mount a xfs filesystem wich is on 
lv over soft raid-0, i'm getting just like in
2.5.2x - 2.5.4x (i didn't try later kernels) :

############################
raid0_make_request bug: can't convert block across chunks or bigger than 16k
25181311 4
raid0_make_request bug: can't convert block across chunks or bigger than 16k
25181343 4
############################

is this know problem, is it fixed ?
i thought that the problem exist only in 2.5 kernel

everything works with reiserfs and jfs
( well not really sure but i could transfer ~10Gb to and from the LV, mkfs ..)

but with xfs got this:
mkfs.xfs -- 
device-mapper: unknown block ioctl 0x6424
device-mapper: unknown block ioctl 0x6424

and with mount again :

raid0_make_request bug: can't convert block across chunks or bigger than 16k
213164570 4
raid0_make_request bug: can't convert block across chunks or bigger than 16k
213164602 4

any hints?

regards,

svetljo
