Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289783AbSBSUNP>; Tue, 19 Feb 2002 15:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289790AbSBSUNC>; Tue, 19 Feb 2002 15:13:02 -0500
Received: from harv10.fnal.gov ([131.225.232.6]:23300 "EHLO harv10.fnal.gov")
	by vger.kernel.org with ESMTP id <S289783AbSBSULl>;
	Tue, 19 Feb 2002 15:11:41 -0500
Message-ID: <3C725D1C.3060001@huhepl.harvard.edu>
Date: Tue, 19 Feb 2002 08:11:40 -0600
From: Joao Guimaraes da Costa <guima@huhepl.harvard.edu>
Organization: Harvard University
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: e2fsck compatibility problem with 2.4.17?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am having a problem that might be due to an incompatibility between
e2fsck and kernel 2.4.17.

My machine has a redhat kernel 2.4.3-12 and a kernel 2.4.17 I have 
recently built from source.

While doing a routine filesystem check at boot time (running kernel 
2.4.17), e2fsck found a problem with one of the partitions (I am using 
e2fsck 1.25 from the redhat rawhide rpm  e2fsprogs-1.25-2.i386.rpm).

I decided not to fix the problem and checked it with a different kernel
and version 1.19 of e2fsck. In both cases, the partition was clean.

So, I get:

kernel     e2fsck    result
2.4.17      1.25     problem
2.4.3-12    1.25      OK
2.4.3-12    1.19      OK

Are there any know incompatibilities between kernel 2.4.17 and e2fsck
1.25? Right now, I am not sure if the filesystem is damaged or not!

The error I get is the following:
1) e2fsck gets stuck after only checking 2.5% of the partition. It stays
   there for about 5 minutes doing clik-clak noises until starting giving
errors
2) First error is:
Block 32783 - 32791 (attempt to read block from filesystem resulted in
short read) while doing inode scan.
3) Then in Pass 2:
resources in /src/linux-2.4.3/drivers/acpi (1894) has deleted/unused
inode 16435.
And it keeps giving many similar messages....

If it is useful I can try to get the full output. This has been 100% 
reproducible in my system.

Thank you,
	-Joao
.


