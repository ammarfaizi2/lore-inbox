Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTH1SM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264109AbTH1SM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:12:27 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:47531 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S264108AbTH1SMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:12:25 -0400
Message-ID: <3F4E4605.6040706@wmich.edu>
Date: Thu, 28 Aug 2003 14:12:21 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tomas <bzzz@tmi.comex.ru>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
References: <m33cfm19ar.fsf@bzzz.home.net>
In-Reply-To: <m33cfm19ar.fsf@bzzz.home.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch seems to be against test2, just wondering if anyone before me 
has used it on the latest test release.  If not then i'm gonna do 
something stupid and be the first.


Alex Tomas wrote:
> this is 2nd version of the patch. changes:
>   - error handling seems completed
>   - lots of cleanups and comments
>   - few minor bug fixed
> 
> this version of the patch tries to solve couple
> of corner cases:
>   - very long truncate
>   - rewrite 
> 
> it survived dbench, bonnie++ and fsx tests.
> 
> take a look at numbers I've just got, please.
> 
>                       before      after
> 5GB file, creation:   2m31.197s   2m21.933s
> 5GB file, read:       2m25.439s   2m24.833s
> 5GB file, rewrite:    2m48.434s   2m20.958s
> 5GB file, removal:    0m8.760s    0m0.858s
> 
>              before           after
> dbench 16:   99.9868 MB/sec   179.243 MB/sec 16 procs
> dbench 16:   89.9919 MB/sec   203.119 MB/sec 16 procs
> dbench 16:   73.5519 MB/sec   185.815 MB/sec 16 procs
> dbench 16:   94.6312 MB/sec   188.519 MB/sec 16 procs
> 
> 
> to use extents you have to use 'extents' mount option
> 
> Alex

