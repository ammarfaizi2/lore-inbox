Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269412AbRIBV3i>; Sun, 2 Sep 2001 17:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRIBV3U>; Sun, 2 Sep 2001 17:29:20 -0400
Received: from [195.66.192.167] ([195.66.192.167]:16911 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S269412AbRIBV3J>; Sun, 2 Sep 2001 17:29:09 -0400
Date: Mon, 3 Sep 2001 00:28:18 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <318476047.20010903002818@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: COW fs (Re: Editing-in-place of a large file)
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu>
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sunday, September 02, 2001, 11:21:37 PM, Bob McElrath wrote:
BM> I would like to take an extremely large file (multi-gigabyte) and edit
BM> it by removing a chunk out of the middle.  This is easy enough by
BM> reading in the entire file and spitting it back out again, but it's
BM> hardly efficent to read in an 8GB file just to remove a 100MB segment.

BM> Is there another way to do this?

BM> Is it possible to modify the inode structure of the underlying
BM> filesystem to free blocks in the middle?  (What to do with the half-full
BM> blocks that are left?)  Has anyone written a tool to do something like
BM> this?

BM> Is there a way to do this in a filesystem-independent manner?

A COW fs is a far more useful and cool. A fs where a copy of a file
does not duplicate all blocks. Blocks get copied-on-write only when
copy of a file is written to. There could be even a fs compressor
which looks for and merges blocks with exactly same contents from
different files.

Maybe ext2/3 folks will play with this idea after ext3?

I'm planning to write a test program which will scan my ext2 fs and
report how many duplicate blocks with the same contents it sees (i.e
how many would I save with a COW fs)
-- 
Best regards,
VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


