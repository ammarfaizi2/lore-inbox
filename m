Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263238AbRFFE5r>; Wed, 6 Jun 2001 00:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263308AbRFFE5h>; Wed, 6 Jun 2001 00:57:37 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:41993 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S263238AbRFFE5Z>;
	Wed, 6 Jun 2001 00:57:25 -0400
Date: Tue, 5 Jun 2001 23:08:04 -0700 (PDT)
From: Alan Olsen <alan@clueserver.org>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <laughing@shared-source.org>
Subject: SCSI is as SCSI don't...
In-Reply-To: <3B1DB270.6070603@blue-labs.org>
Message-ID: <Pine.LNX.4.10.10106052247210.17745-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to get 2.4.5 and/or 2.4.5-ac9 working.  Both are choking on
compile with an odd error message or four...

In file included from /usr/src/linux-2.4.5-ac9/include/linux/raid/md.h:50,
                 from ll_rw_blk.c:30:
/usr/src/linux-2.4.5-ac9/include/linux/raid/md_k.h: In function
`pers_to_level':/usr/src/linux-2.4.5-ac9/include/linux/raid/md_k.h:41:
warning: control reaches end of non-void function

I am seeing similar messages in the AIC7xxx code.

The basic effect is that the kernel will not load.  Something breaks hard
in it.

My C is pretty rusty. (Too much IS work as of late...)  Does anyone know
what this message is and why it is occuring?

I am currently using 2.4.4-ac11 and it does not have this problem.  

My reason for upgrading is that cdrecord gave me the following error, and
I was hoping that 2.4.5 would have fixed it...

Starting new track at sector: 0
CDB:  2A 00 00 00 9E FF 00 00 1F 80
cdrecord: Input/output error. write_teac_g1: scsi sendcmd: retryable error
Sense Bytes: 70 00 0B 00 00 00 00 0A 00 00 00 01 BA 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Key: 0xB Aborted Command, Segment 0
Sense Code: 0xBA Qual 0x00 (no write data - buffer empty) Fru 0x0
Sense flags: Blk 0 (not valid)

cdrecord: Input/output error. write_teac_g1: scsi sendcmd: retryable error
write track data: error after 83359744 bytes
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 00 00 00 00 00 0A 00 00 00 00 00 00 00 00 00 00
WARNING: adding dummy block to close track.
CDB:  2A 00 00 00 9E FF 00 00 01 00
Sense Bytes: 70 00 0B 00 00 00 00 0A 00 00 00 01 BA 00 00 00
Sense Key: 0xB Aborted Command, Segment 0
Sense Code: 0xBA Qual 0x00 (no write data - buffer empty) Fru 0x0
Sense flags: Blk 0 (not valid)

Ideas...?  (At least it give me time to finish Linus's autobiography while
I am rebuilding things, but I am quickly running out of book. ]:> )

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

