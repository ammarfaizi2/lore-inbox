Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSEBTWm>; Thu, 2 May 2002 15:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSEBTWj>; Thu, 2 May 2002 15:22:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65293 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315372AbSEBTWf>;
	Thu, 2 May 2002 15:22:35 -0400
Message-ID: <3CD191C5.AC09B1F4@zip.com.au>
Date: Thu, 02 May 2002 12:21:41 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Pittman <daniel@rimspace.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
In-Reply-To: <87u1pqln4h.fsf@enki.rimspace.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Pittman wrote:
> 
> I gave the 2.5.12 kernel a shot on my workstation tonight and found an
> *extremely* serious ext3 filesystem corrupting behavior.

A few things..

Are your other filesystems using journalled data as well?

Are you sure that all kernel files were recompiled?  If,
for example, you had some 2.5.11 objects in the link, that
would be bad.

Do you know whether the bad data is actually on-disk, or
could it be just in-RAM?  ie: was the data still bad after
a reboot?

What blocksize is that filesystem using?  The output of
`dumpe2fs -h /dev/whatever' will tell you this.

Can you please force an fsck against that filesystem,
see what it says?

Thanks. 

-
