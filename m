Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284970AbSAIVWs>; Wed, 9 Jan 2002 16:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288966AbSAIVWj>; Wed, 9 Jan 2002 16:22:39 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:31245 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S284970AbSAIVW0> convert rfc822-to-8bit; Wed, 9 Jan 2002 16:22:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [PATCH} Tape drive support for cciss driver 2.5.2-pre10
Date: Wed, 9 Jan 2002 15:22:19 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CF1E@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH} Tape drive support for cciss driver 2.5.2-pre10
Thread-Index: AcGZU7ggyhJz4wD5SfaKFzhNjbSCRw==
From: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
To: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Cc: "White, Charles" <Charles.White@COMPAQ.com>
X-OriginalArrivalTime: 09 Jan 2002 21:22:20.0417 (UTC) FILETIME=[B8C26F10:01C19953]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Charles White and I have been maintaining a rather large and
growing patch for the cciss driver, which seems to get mostly
ignored.

So, suspecting perhaps that the problem is the patch is too
big and tries to do to much, I have started breaking it up
into pieces.

Here is one such piece which applies to 2.5.2-pre10:

http://www.geocities.com/smcameron/ccisstape_for_2.5.2-pre10.patch.gz

This patch adds support for SCSI tape drives and medium changers 
to the cciss driver.  The patch doesn't do anything else to my
knowledge.
I don't think this patch can be made significantly smaller and still 
be useful.

Note, the changes which this patch implements are already
described in Documentation/cciss.txt in the current kernel tree
as the Documentation portion the larger patch (but nothing else)
was merged in some time ago for some reason.  (So currently
the Documentation/cciss.txt is incorrect without this patch.)

I have tried the patch booting from the cciss driver
with two tape drives attached, and can successfully do i/o to 
disks and both tape drives simultaneously.

The tape drive support can be configured on or off.  If off,
then the relevant code is not compiled.

Please consider applying, and feel free to comment.

-- steve
