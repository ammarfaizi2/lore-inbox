Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbUBRLQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbUBRLQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:16:27 -0500
Received: from shockwave.systems.pipex.net ([62.241.160.9]:36330 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264463AbUBRLOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:14:44 -0500
Message-ID: <4033491C.40407@emergence.uk.net>
Date: Wed, 18 Feb 2004 11:14:36 +0000
From: Jonathan Brown <jbrown@emergence.uk.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
References: <20040217232130.61667965.akpm@osdl.org>
In-Reply-To: <20040217232130.61667965.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to startx with this kernel I get this error:

(EE) RADEON(0): shmat() call retruned errno 1013

No problem with similar .config on 2.6.3. Can post .config if necessary.

Jonathan Brown
http://emergence.uk.net/


Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3/2.6.3-mm1/
> 
> - Added the dm-crypt driver: a crypto layer for device-mapper.
> 
>   People need to test and use this please.  There is documentation at
>   http://www.saout.de/misc/dm-crypt/.
> 
>   We should get this tested and merged up.  We can then remove the nasty
>   bio remapping code from the loop driver.  This will remove the current
>   ordering guarantees which the loop driver provides for journalled
>   filesystems.  ie: ext3 on cryptoloop will no longer be crash-proof.
> 
>   After that we should remove cryptoloop altogether.
> 
>   It's a bit late but cyptoloop hasn't been there for long anyway and it
>   doesn't even work right with highmem systems (that part is fixed in -mm).
> 
> - Added the fbdev cursor API patch.  Not sure what this does apart from
>   preventing the rivafb driver from linking.  I'll let others decide if this
>   is progress.
> 
> - There's a patch here to consolidate the 32->64 compat code for the IPC
>   syscalls.  Needs testing on various 64-bit machines.
> 
> - Various random fixes to things.
