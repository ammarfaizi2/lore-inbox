Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274989AbRJJXLp>; Wed, 10 Oct 2001 19:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277527AbRJJXLg>; Wed, 10 Oct 2001 19:11:36 -0400
Received: from [216.151.155.121] ([216.151.155.121]:61457 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S274989AbRJJXLT>; Wed, 10 Oct 2001 19:11:19 -0400
To: Lew Wolfgang <wolfgang@sweet-haven.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Dump corrupts ext2?
In-Reply-To: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com>
From: Doug McNaught <doug@wireboard.com>
Date: 10 Oct 2001 19:11:43 -0400
In-Reply-To: Lew Wolfgang's message of "Wed, 10 Oct 2001 16:03:48 -0700 (PDT)"
Message-ID: <m3elob3xao.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lew Wolfgang <wolfgang@sweet-haven.com> writes:

> Hi Folks,
> 
> I was looking for some scripts to backup ext2 partitions
> to multiple CDR's when I stumbled onto "cdbackup" at
> http://www.cableone.net/ccondit/cdbackup/.
> 
> Alas, there is a warning saying:
> 
> "WARNING! When using this program under Linux, be sure not to use
>  dump with kernels in the 2.4.x series. Using dump on an ext2
>  filesystem has a very high potential for causing filesystem
>  corruption.  As of kernel version 2.4.5, this has not been
>  resolved, and it may not be for some time."
> 
> I don't recall any problems like this, does anyone have
> additional comments?

I'm pretty sure this is because dump reads the block device directly
(which is cached in the buffer cache), while the file data for cached
files lives in the page cache, and the two caches are no longer
coherent (as of 2.4).

If you can find it, Linus has ranted on this list at least once about
why you should never use 'dump'...

If you're doing backups under 2.4, use tar or cpio.

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
