Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSELCHo>; Sat, 11 May 2002 22:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSELCHn>; Sat, 11 May 2002 22:07:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11532 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315278AbSELCHn>;
	Sat, 11 May 2002 22:07:43 -0400
Date: Sun, 12 May 2002 03:07:42 +0100
From: Matthew Wilcox <willy@debian.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: fs/locks.c BKL removal
Message-ID: <20020512030742.P32414@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <3CDC4037.8040104@us.ibm.com> <20020511204551.M32414@parcelfarce.linux.theplanet.co.uk> <3CDDC7F0.6010407@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 06:40:00PM -0700, Dave Hansen wrote:
> Do you really think a single lock is the way to go?  Maybe I'm just 
> paranoid, but somebody is going to run into a locking bottleneck here 
> eventually.  I also just don't like global locks.

Well, we have a global entity being protected -- the file_lock_list.
Clearly we don't want to use one of the existing per-inode semaphores
since semaphores have a noted bad effect on both benchmarks and real-world
scenarios.  And I don't think introducing a new per-inode lock would
really be welcome.

> I'll ask our benchmarking team if they have test suites for file 
> locking.  I crossing my fingers.

Cool, thanks.

-- 
Revolutions do not require corporate support.
