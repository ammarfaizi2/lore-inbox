Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276489AbRJCQ3c>; Wed, 3 Oct 2001 12:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276483AbRJCQ3W>; Wed, 3 Oct 2001 12:29:22 -0400
Received: from charon.geminidataloggers.com ([194.200.199.164]:17937 "EHLO
	charon.geminidataloggers.com") by vger.kernel.org with ESMTP
	id <S276465AbRJCQ3N> convert rfc822-to-8bit; Wed, 3 Oct 2001 12:29:13 -0400
From: Toby Dickenson <tdickenson@devmail.geminidataloggers.co.uk>
To: pcg@goof.com
Cc: foner-reiserfs@media.mit.edu, sct@redhat.com, Nikita@namesys.com,
        Mason@Suse.COM, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] ReiserFS data corruption in very simple configuration
Date: Wed, 03 Oct 2001 17:28:13 +0100
Reply-To: tdickenson@geminidataloggers.com
Message-ID: <kcemrtsndajld34h6a9il3nufocbgq5stv@4ax.com>
In-Reply-To: <20010929145229.C26231@schmorp.de> <200110010100.VAA07189@out-of-band.media.mit.edu> <20011001032627.A9991@schmorp.de>
In-Reply-To: <20011001032627.A9991@schmorp.de>
X-Mailer: Forte Agent 1.7/32.534
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Of course. If you want data to hit the disk, you have to use fsync. This
>does work with reiserfs and will ensure that the data hits the disk. If
>you don't do this then bad things might happen.

This is probably a naive question, but this thread has already proved
me wrong on one naive assumption.....

If the sequence is:
1. append some data to file A
2. fsync(A)
3. append some further data to A
4. some writes to other files
5. power loss

Is it guaranteed that all the data written in step 1 will still be
intact?

The potential problem I can see is that some data from step 1 may have
been written in a tail, the tail moves during step 3, and then the
original tail is overwritten before the new tail (including data from
before the fsync) is safely on disk.

Thanks for your help,


Toby Dickenson
tdickenson@geminidataloggers.com
