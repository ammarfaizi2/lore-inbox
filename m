Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262048AbTCHPoW>; Sat, 8 Mar 2003 10:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262051AbTCHPoW>; Sat, 8 Mar 2003 10:44:22 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:19211 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262048AbTCHPoV>; Sat, 8 Mar 2003 10:44:21 -0500
Date: Sat, 8 Mar 2003 15:54:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 6/6 cacheline align files_lock
Message-ID: <20030308155456.B28797@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>
References: <52550000.1047080176@flay> <20030308073535.B24272@infradead.org> <393020000.1047138100@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <393020000.1047138100@[10.10.2.4]>; from mbligh@aracnet.com on Sat, Mar 08, 2003 at 07:41:42AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 07:41:42AM -0800, Martin J. Bligh wrote:
> It seems to lock several different things though - free lists, tty lists,
> etc, etc. I could break it up to one per list, but that means taking two
> locks to shift between lists, which I'd prefer not to do if possible.

The free list should go away - we have slab for that.  The tty stuff should
get a per-tty lock.

