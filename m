Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312855AbSD2Q2W>; Mon, 29 Apr 2002 12:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312889AbSD2Q2V>; Mon, 29 Apr 2002 12:28:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:55738 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312855AbSD2Q2U>; Mon, 29 Apr 2002 12:28:20 -0400
Message-ID: <3CCD672E.5040005@us.ibm.com>
Date: Mon, 29 Apr 2002 08:30:54 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
In-Reply-To: <20020429141301.B16778@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
 > Kernel 2.5.8... Devfs devfs_open() bypasses the normal chrdev_open
 > and blkdev_open functions, and misses out taking the BKL.  2.5.10 is
 > the same.
 >
 > Certainly the tty layer (and probably many of the other devices as
 > well) require the BKL to be taken before calling the open method.

Has the time come to push the BKL down into all of the driver open()s?
It's going to be a lot of work, but it has to happen eventually, right?

-- 
Dave Hansen
haveblue@us.ibm.com

