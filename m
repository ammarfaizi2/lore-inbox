Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUBRKnJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 05:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbUBRKnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 05:43:09 -0500
Received: from ns.suse.de ([195.135.220.2]:34179 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264288AbUBRKnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 05:43:06 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm1
References: <20040217232130.61667965.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Feb 2004 11:43:00 +0100
In-Reply-To: <20040217232130.61667965.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p73wu6k653f.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

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

Is it guaranteed that this thing will be disk format compatible to cryptoloop? 
(mainly in IVs and crypto algorithms)

While 2.3 and 2.4 have broken the on disk format of crypto loop several
times (each time to a new "improved and ultimately perfect format")
I don't think that's acceptable for a mature OS anymore.

-Andi
