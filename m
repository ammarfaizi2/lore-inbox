Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291443AbSBHGnW>; Fri, 8 Feb 2002 01:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291444AbSBHGnM>; Fri, 8 Feb 2002 01:43:12 -0500
Received: from angband.namesys.com ([212.16.7.85]:34694 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S291443AbSBHGnC>; Fri, 8 Feb 2002 01:43:02 -0500
Date: Fri, 8 Feb 2002 09:43:01 +0300
From: Oleg Drokin <green@namesys.com>
To: Sebastian Dr?ge <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Next "Problem" with ReiserFS: vs-825: reiserfs_get_block: [799572 866493 0x3001 UNKNOWN] should not be found
Message-ID: <20020208094301.A7197@namesys.com>
In-Reply-To: <20020207140745.52eebb57.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020207140745.52eebb57.sebastian.droege@gmx.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Feb 07, 2002 at 02:07:45PM +0100, Sebastian Dr?ge wrote:

> I'm currently running 2.5.3-dj3 with the "fix for inodes with wrong item versions" and got the following errors in dmesg:
> vs-825: reiserfs_get_block: [283508 198 0x19001 UNKNOWN] should not be found
> [many times]
> and after a while:
> vs-825: reiserfs_get_block: [799572 866493 0x3001 UNKNOWN] should not be found
> [many times]
This is very strange in fact.
What do you do to get these messages?

> What does this mean?
It means that when we are trying to insert a new block in list of file's blocks
(to fill a hole or something) we encountering that somebody have inserted
the block while we were doing other things.

This was the case with truncating file past its end and then mmap-writing there.
But this particular place was fixed by introducing "expanding truncate" patch.

And please CC reiserfs specific bugreports to reiserfs-list@namesys.com

Thank you.

Bye,
    Oleg
