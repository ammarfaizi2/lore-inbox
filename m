Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbTAKIBv>; Sat, 11 Jan 2003 03:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbTAKIBv>; Sat, 11 Jan 2003 03:01:51 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:20242 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267158AbTAKIBu>; Sat, 11 Jan 2003 03:01:50 -0500
Date: Sat, 11 Jan 2003 08:10:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Joe Korty <joe.korty@ccur.com>, sct@redhat.com, adilger@clusterfs.com,
       rusty@rustcorp.com.au, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre2 stalls out when running unixbench
Message-ID: <20030111081025.A19877@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@digeo.com>, Joe Korty <joe.korty@ccur.com>,
	sct@redhat.com, adilger@clusterfs.com, rusty@rustcorp.com.au,
	riel@conectiva.com.br, linux-kernel@vger.kernel.org
References: <3E15F2F5.356A933D@digeo.com> <200301040111.BAA00401@rudolph.ccur.com> <3E16C171.BFEA45AE@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E16C171.BFEA45AE@digeo.com>; from akpm@digeo.com on Sat, Jan 04, 2003 at 03:11:45AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 03:11:45AM -0800, Andrew Morton wrote:
> Sure, we don't need atomic semantics for the BH_Attached bit because
> it is always read and modified under a global spinlock.  But *other*
> users of buffer_head.b_state do not run under that lock so the nonatomic
> RMW will stomp on their changes.   2.4.20 does not have this bug.

Thanks, I still had to learn something about *_bit() semantics.

And sorry for introducing that bug..

