Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132686AbREIVV1>; Wed, 9 May 2001 17:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133070AbREIVVS>; Wed, 9 May 2001 17:21:18 -0400
Received: from host-64-65-206-13.choiceone.net ([64.65.206.13]:15687 "EHLO
	isaiah.tpr-east.com") by vger.kernel.org with ESMTP
	id <S132686AbREIVVC>; Wed, 9 May 2001 17:21:02 -0400
Message-ID: <3AF9B411.2A0F3F43@tpr.com>
Date: Wed, 09 May 2001 17:18:09 -0400
From: Mark Bratcher <bratcher@tpr.com>
Organization: Torrey Pines Research
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: bratcher@tpr.com
Subject: ATAPI Tape Driver Failure in Kernel 2.4.4, More
In-Reply-To: <3AF9558F.9C76953C@tpr.com>
Content-Type: multipart/mixed;
 boundary="------------C51193CFE1F8FF2CDF30FE2F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C51193CFE1F8FF2CDF30FE2F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I just upgraded from kernel 2.2.17 to 2.4.4. I use a Seagate ATAPI tape drive,
model STT20000A. I use dump to do backups (probably not relevant).

I have more data regarding tape backup failures. Here is what I get:

* In a full tape dump of about 50MB or so, everything goes smoothly. No errors.

* In a full tape dump of a little over 1GB (to a 10GB tape), I get the following
errors
immediately after the backup completes and I try to write a file mark with "mt":

May  9 16:50:49 isaiah kernel: ide-tape: Reached idetape_chrdev_open 
May  9 16:52:05 isaiah kernel: hdd: irq timeout: status=0xd0 { Busy } 
May  9 16:52:05 isaiah kernel: hdd: ATAPI reset complete 
May  9 16:52:05 isaiah kernel: ide-tape: Couldn't write a filemark 
May  9 16:52:06 isaiah kernel: ide-tape: Reached idetape_chrdev_open 
May  9 16:54:06 isaiah kernel: ide-tape: ht0: DSC timeout 
May  9 16:54:06 isaiah kernel: hdd: ATAPI reset complete 
May  9 16:54:06 isaiah kernel: ide-tape: ht0: I/O error, pc = 10, key =  2, asc
=  4,
ascq =  1 
May  9 16:54:06 isaiah kernel: ide-tape: ht0: I/O error, pc = 34, key =  2, asc
=  4,
ascq =  1 

* In a full tape dump of between 6GB and 7GB, the backup completes, I
successfully write a tape file mark with "mt", rewind, then attempt to compare.
I get:

May  9 04:21:18 isaiah kernel: ide-tape: Reached idetape_chrdev_open 
May  9 04:22:35 isaiah kernel: ide-tape: bh == NULL in
idetape_copy_stage_to_user 
May  9 04:22:35 isaiah kernel: ide-tape: bh == NULL in
idetape_copy_stage_to_user 
May  9 04:22:36 isaiah kernel: ide-tape: Reached idetape_chrdev_open 

The errors are repeatable and do not occur in 2.2.17. At this rate, I'll have to
go back to 2.2.17 to get successful backup scripts working.

Anyone know what causes this problem?

Please reply directly, as I'm not a member of this list.

Thanks :-)
Mark Bratcher
--------------C51193CFE1F8FF2CDF30FE2F
Content-Type: text/x-vcard; charset=us-ascii;
 name="bratcher.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Mark Bratcher
Content-Disposition: attachment;
 filename="bratcher.vcf"

begin:vcard 
n:Bratcher;Mark
tel;fax:716/288-4604
tel;work:716/288-7220
x-mozilla-html:FALSE
url:www.tpr.com
org:Torrey Pines Research
version:2.1
email;internet:bratcher@tpr.com
title:Director of Software Development
adr;quoted-printable:;;565 Blossom Road=0D=0ASuite A;Rochester;New York;14610;USA
x-mozilla-cpt:;19472
fn:Bratcher, Mark
end:vcard

--------------C51193CFE1F8FF2CDF30FE2F--

