Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311650AbSDSEiS>; Fri, 19 Apr 2002 00:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSDSEiR>; Fri, 19 Apr 2002 00:38:17 -0400
Received: from holomorphy.com ([66.224.33.161]:22944 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S311650AbSDSEiQ>;
	Fri, 19 Apr 2002 00:38:16 -0400
Date: Thu, 18 Apr 2002 21:37:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: viro@math.psu.edu
Subject: Re: [RFC] 2.4 truncate locking
Message-ID: <20020419043729.GZ21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
In-Reply-To: <20020417150912.GI23767@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 08:09:12AM -0700, William Lee Irwin III wrote:
> I did some research on how truncate_inode_pages()'s locking works.
> Please feel free to clarify and/or correct my notes on the subject,
> which I'd like to turn into a docpatch soon.
>
> (9) exclusion from simultaneous manipulation of page->mapping
> 	pagemap_lru_lock

This is incorrect. It appears to be a combination of PG_locked and
pagecache_lock, where both are required for writing, and only one of
the two for reading.


Cheers,
Bill
