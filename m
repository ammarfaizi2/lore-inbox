Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265918AbRF1Nwy>; Thu, 28 Jun 2001 09:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265902AbRF1Nwo>; Thu, 28 Jun 2001 09:52:44 -0400
Received: from picard.csihq.com ([204.17.222.1]:45953 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S265905AbRF1Nwd>;
	Thu, 28 Jun 2001 09:52:33 -0400
Message-ID: <032f01c0ffd9$8bfc2e80$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        "raid" <linux-raid@vger.kernel.org>
In-Reply-To: <02bd01c0ffcf$6a85f150$e1de11cc@csihq.com> <3B3B291A.3DFDA2A4@uow.edu.au>
Subject: 2.2.6-pre6 ext3 Part II
Date: Thu, 28 Jun 2001 09:52:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to recover from ext3 journal failure....swtiched drive back to ext2

Now my fiber channel driver is complaining:
qlogicfc0: no handle slots, this should not happen.
hostdata->queue  is 2a, inptr: 74
And a bunch more (77,79,7b,7d,7e) after which it locks up completely.

This is while the raid5 is resyncing and it's trying to do an e2fsck at the
same time.

I'm now going to try letting the resync complete before doing the e2fsck.

Looks like I'm just running into cascading problems here...sigh...

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

