Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289007AbSBMWEK>; Wed, 13 Feb 2002 17:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSBMWEC>; Wed, 13 Feb 2002 17:04:02 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:60923 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S289010AbSBMWDu>; Wed, 13 Feb 2002 17:03:50 -0500
Date: Wed, 13 Feb 2002 14:03:46 -0800
From: Daniel Schepler <schepler@math.berkeley.edu>
Subject: What does AddrMarkNotFound mean?
To: linux-kernel@vger.kernel.org
Message-id: <873d059gzh.fsf@frobnitz.ddts.net>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Mail-Copies-To: schepler@math.berkeley.edu
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lately, whenever I try to access a certain part of my hard drive, I
get messages like:

Feb 12 21:16:27 localhost kernel: hdc: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
Feb 12 21:16:27 localhost kernel: hdc: read_intr: error=0x01 { AddrMarkNotFound }, LBAsect=34508632, sector=32410984
Feb 12 21:16:27 localhost kernel: ide1: reset: success
Feb 12 21:16:27 localhost kernel: hdc: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
Feb 12 21:16:27 localhost kernel: hdc: read_intr: error=0x01 { AddrMarkNotFound }, LBAsect=34508632, sector=32410984
Feb 12 21:16:27 localhost kernel: end_request: I/O error, dev 16:02 (hdc), sector 32410984

except that the first two messages are repeated several more times, at
intervals of a few seconds.  Also, during the first bad access, DMA
gets disabled.  While this is going on, the system load goes way up,
and I don't seem to be able to do anything else.

Is this typical behavior for a hard drive which has developed bad
blocks?  And if I blacklist the affected blocks in the filesystem,
should I also blacklist a few previous blocks in order to avoid
problems with the readahead feature of the IDE drivers?

(I'm not subscribed; please Cc me on replies.)
-- 
Daniel Schepler              "Please don't disillusion me.  I
schepler@math.berkeley.edu    haven't had breakfast yet."
                                 -- Orson Scott Card
