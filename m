Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316293AbSELBki>; Sat, 11 May 2002 21:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316294AbSELBkh>; Sat, 11 May 2002 21:40:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50153 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316293AbSELBkg>;
	Sat, 11 May 2002 21:40:36 -0400
Message-ID: <3CDDC7F0.6010407@us.ibm.com>
Date: Sat, 11 May 2002 18:40:00 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020504
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: fs/locks.c BKL removal
In-Reply-To: <3CDC4037.8040104@us.ibm.com> <20020511204551.M32414@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> Ick... I'd really like to see one spinlock protecting all activity in this
> area.  And obviously not the magic BKL ;-)

Do you really think a single lock is the way to go?  Maybe I'm just 
paranoid, but somebody is going to run into a locking bottleneck here 
eventually.  I also just don't like global locks.

I'll ask our benchmarking team if they have test suites for file 
locking.  I crossing my fingers.

-- 
Dave Hansen
haveblue@us.ibm.com

