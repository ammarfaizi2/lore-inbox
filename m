Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280599AbRKBIBk>; Fri, 2 Nov 2001 03:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280596AbRKBIBa>; Fri, 2 Nov 2001 03:01:30 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:39948 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S280595AbRKBIBL>; Fri, 2 Nov 2001 03:01:11 -0500
Message-ID: <3BE2529A.63B1C366@idb.hist.no>
Date: Fri, 02 Nov 2001 09:00:26 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre6
In-Reply-To: message from Linus Torvalds on Wednesday October 31,
			<Pine.LNX.4.33.0110310809200.32460-100000@penguin.transmeta.com> <15329.8658.642254.284398@notabene.cse.unsw.edu.au> <3BE1B6CD.7DA43A6C@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Another potential microoptimisation would be to write out
> clean blocks if that helps merging.  So if we see a write
> for blocks 1,2,3,5,6,7 and block 4 is known to be in memory,
> then write it out too.  I suspect this would be a win for
> ATA but a loss for SCSI.  Not sure.
> 

A not to stupid disk would implement the seek to block 5
as waiting for block 4 to move past.  So
rewriting block 4 probably wouldn't help.  could be 
interesting to see a benchmark for that though, perhaps
some drives are really dumb.

The average "half rotation delay" when seeking does not apply
when the seek _isn't_ random.

Helge Hafting
