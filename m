Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbQLOOnB>; Fri, 15 Dec 2000 09:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130606AbQLOOmm>; Fri, 15 Dec 2000 09:42:42 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:14600 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S130180AbQLOOmb>;
	Fri, 15 Dec 2000 09:42:31 -0500
Date: Fri, 15 Dec 2000 12:31:33 +0100
From: Stanislav Brabec <utx@penguin.cz>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: ATAPI: audio CD still stops on >> (fast forward, 2.4.0-test12)
Message-ID: <20001215123132.A790@utx.cz>
In-Reply-To: <20001103235437.B5574@utx.cz> <20001104151845.E12610@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001104151845.E12610@suse.de>; from axboe@suse.de on Sat, Nov 04, 2000 at 03:18:45PM +0100
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote, Sat Nov  4, 2000, 15:18:45 GMT):
> On Fri, Nov 03 2000, Stanislav Brabec wrote:
> > Description:
> > On 2.4.0-pre9 and 2.4.0-pre10:
> > Playing of some audio CD's stops in nearly regular places. Also pressing
> > >> in CD software panel in nearly all cases ends by stop.
> 
> Known problem, patch not submitted yet.
> 

- play CD audio correctly, don't stop after 12 minutes.

Patch in 2.4.0-test12 really fixes this problem.

But problem with >> (fast forward playng of short samples) still remains
on some audio CD's.

HW:
ATAPI CD-ROM Mitsumi FX400E (4x speed)
Cyrix686MX200

SW:
tcd/gtcd

Dec 15 12:17:25 utx kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete Error } 
Dec 15 12:17:25 utx kernel: hdb: packet command error: error=0x50 
Dec 15 12:17:25 utx kernel: ATAPI device hdb: 
Dec 15 12:17:25 utx kernel:   Error: Illegal request -- (Sense key=0x05) 
Dec 15 12:17:25 utx kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00) 
Dec 15 12:17:25 utx kernel:   The failed "Play Audio MSF" packet command was:  
Dec 15 12:17:25 utx kernel:   "47 00 00 00 02 00 3c 3a ff 00 00 00 " 
Dec 15 12:17:41 utx kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete Error } 
Dec 15 12:17:41 utx kernel: hdb: packet command error: error=0x50 
Dec 15 12:17:41 utx kernel: ATAPI device hdb: 
Dec 15 12:17:41 utx kernel:   Error: Illegal request -- (Sense key=0x05) 
Dec 15 12:17:41 utx kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00) 
Dec 15 12:17:41 utx kernel:   The failed "Play Audio MSF" packet command was:  
Dec 15 12:17:41 utx kernel:   "47 00 00 00 1b 00 3c 3a ff 00 00 00 " 
Dec 15 12:17:44 utx kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete Error } 
Dec 15 12:17:44 utx kernel: hdb: packet command error: error=0xb0 
Dec 15 12:17:44 utx kernel: ATAPI device hdb: 
Dec 15 12:17:44 utx kernel:   Error: Aborted command -- (Sense key=0x0b) 
Dec 15 12:17:44 utx kernel:   Play operation aborted -- (asc=0xb9, ascq=0x00) 
Dec 15 12:17:44 utx kernel:   The failed "Pause/Resume" packet command was:  
Dec 15 12:17:44 utx kernel:   "4b 00 00 00 00 00 00 00 00 00 00 00 " 
Dec 15 12:17:45 utx kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete Error } 
Dec 15 12:17:45 utx kernel: hdb: packet command error: error=0x50 
Dec 15 12:17:45 utx kernel: ATAPI device hdb: 
Dec 15 12:17:45 utx kernel:   Error: Illegal request -- (Sense key=0x05) 
Dec 15 12:17:45 utx kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00) 
Dec 15 12:17:45 utx kernel:   The failed "Play Audio MSF" packet command was:  
Dec 15 12:17:45 utx kernel:   "47 00 00 00 22 00 3c 3a ff 00 00 00 " 
Dec 15 12:17:46 utx kernel: hdb: packet command error: status=0x51 { DriveReady SeekComplete Error } 
Dec 15 12:17:46 utx kernel: hdb: packet command error: error=0x50 
Dec 15 12:17:46 utx kernel: ATAPI device hdb: 
Dec 15 12:17:46 utx kernel:   Error: Illegal request -- (Sense key=0x05) 
Dec 15 12:17:46 utx kernel:   Invalid field in command packet -- (asc=0x24, ascq=0x00) 
Dec 15 12:17:46 utx kernel:   The failed "Play Audio MSF" packet command was:  
Dec 15 12:17:46 utx kernel:   "47 00 00 00 02 00 3c 3a ff 00 00 00 " 

-- 
Stanislav Brabec
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
