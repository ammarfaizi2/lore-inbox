Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbUBVBUh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 20:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbUBVBUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 20:20:37 -0500
Received: from holomorphy.com ([199.26.172.102]:64004 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261639AbUBVBUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 20:20:35 -0500
Date: Sat, 21 Feb 2004 17:20:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-ID: <20040222012033.GC703@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <4037FCDA.4060501@matchmail.com> <4038014E.5070600@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4038014E.5070600@matchmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
>>I have 1.5 GB of ram in this system that will be a Linux Terminal Server 
>> (but using Debian & VNC).  There's 600MB+ anonymous memory, 600MB+ slab 
>> cache, and 100MB page cache.  That's after turning off swap (it was 
>> 400MB into swap at the time).

On Sat, Feb 21, 2004 at 05:09:34PM -0800, Mike Fedyk wrote:
> Here's my top slab users:
> dentry_cache      585455 763395    256   15    1 : tunables  120   60 
>  8 : slabdata  50893  50893      3
> ext3_inode_cache  686837 688135    512    7    1 : tunables   54   27 
>  8 : slabdata  98305  98305      0
> buffer_head        34095  78078     48   77    1 : tunables  120   60 
>  8 : slabdata   1014   1014      0
> vm_area_struct     42103  44602     64   58    1 : tunables  120   60 
>  8 : slabdata    769    769      0
> pte_chain          20964  43740    128   30    1 : tunables  120   60 
>  8 : slabdata   1458   1458      0

Similar issue here; I ran out of filp's/whatever shortly after booting.


-- wli
