Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291487AbSCDFEW>; Mon, 4 Mar 2002 00:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291484AbSCDFEL>; Mon, 4 Mar 2002 00:04:11 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:17651
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291477AbSCDFEG>; Mon, 4 Mar 2002 00:04:06 -0500
Date: Sun, 3 Mar 2002 21:04:50 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Steve Lord <lord@sgi.com>
Subject: Re: [patch] delayed disk block allocation
Message-ID: <20020304050450.GF353@matchmail.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>, Steve Lord <lord@sgi.com>
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16hhuI-0000S6-00@starship.berlin>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 03:08:54AM +0100, Daniel Phillips wrote:
> The main disconnect there is sub-page sized writes, you will bundle together
> young and old 1K buffers.  Since it's getting harder to find a 1K blocksize
> filesystem, we might not care.  

Please don't do that.

Hopefully, once this is in, 1k blocks will work much better.  There are many
cases where people work with lots of small files, and using 1k blocks is bad
enough, 4k would be worse.

Also, with dhash going into ext2/3 lots of tiny files in one dir will be
feasible and comparible with reiserfs.
