Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDKx5>; Sat, 4 Nov 2000 05:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129130AbQKDKxi>; Sat, 4 Nov 2000 05:53:38 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:4880 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S129033AbQKDKxZ>;
	Sat, 4 Nov 2000 05:53:25 -0500
Date: Fri, 3 Nov 2000 23:54:38 +0100
From: Stanislav Brabec <utx@penguin.cz>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: ATAPI: audio CD stops playing (2.2.17 & 2.4.0-test?)
Message-ID: <20001103235437.B5574@utx.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
On 2.4.0-pre9 and 2.4.0-pre10:
Playing of some audio CD's stops in nearly regular places. Also pressing >> in CD software
panel in nearly all cases ends by stop.

All these stops are reported:
Nov  3 21:41:47 utx kernel: ATAPI device hdb: 
Nov  3 21:41:47 utx kernel:   Error: Illegal request -- (Sense key=0x05) 
Nov  3 21:41:47 utx kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00) 
Nov  3 21:41:47 utx kernel:   The failed "Play Audio MSF" packet command was:  
Nov  3 21:41:47 utx kernel:   "47 00 00 00 02 00 3c 3a ff 00 00 00 " 

On 2.2.17:
Rejects to play audio CD on this hardware at all with report:
Oct 19 15:24:15 utx kernel: ATAPI device hdb: 
Oct 19 15:24:15 utx kernel:   Error: Illegal request -- (Sense key=0x05) 
Oct 19 15:24:15 utx kernel:   Invalid command operation code -- (asc=0x20, ascq=0x00) 
Oct 19 15:24:15 utx kernel:   The failed "Play Audio TrackIndex" packet command was:  
Oct 19 15:24:15 utx kernel:   "48 00 00 00 01 01 00 0d 01 00 00 00 " 
Oct 19 15:24:26 utx kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete Error } 
Oct 19 15:24:26 utx kernel: hdb: packet command error: error=0x50 
Oct 19 15:24:26 utx kernel: ATAPI device hdb: 
Oct 19 15:24:26 utx kernel:   Error: Illegal request -- (Sense key=0x05) 
Oct 19 15:24:26 utx kernel:   Invalid command operation code -- (asc=0x20, ascq=0x00) 
Oct 19 15:24:26 utx kernel:   The failed "Play Audio TrackIndex" packet command was:  
Oct 19 15:24:26 utx kernel:   "48 00 00 00 01 01 00 0d 01 00 00 00 " 

linux-2.2.16 works OK


HW&SW:
ATAPI CD-ROM Mitsumi FX400E (4x speed)

Cyrix686MX200


Compiler:
gcc-2.96.2


-- 
Stanislav Brabec
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
