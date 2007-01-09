Return-Path: <linux-kernel-owner+w=401wt.eu-S1751262AbXAIKC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbXAIKC5 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbXAIKC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:02:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37804 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbXAIKC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:02:56 -0500
Date: Tue, 9 Jan 2007 10:02:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Chinner <dgc@sgi.com>, Eric Sandeen <sandeen@sandeen.net>,
       linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: bd_mount_mutex -> bd_mount_sem (was Re: xfs_file_ioctl / xfs_freeze: BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock())
Message-ID: <20070109100252.GA14713@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, David Chinner <dgc@sgi.com>,
	Eric Sandeen <sandeen@sandeen.net>,
	linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
	xfs@oss.sgi.com
References: <20070104001420.GA32440@m.safari.iki.fi> <20070107213734.GS44411608@melbourne.sgi.com> <20070108110323.GA3803@m.safari.iki.fi> <45A27416.8030600@sandeen.net> <20070108234728.GC33919298@melbourne.sgi.com> <20070108161917.73a4c2c6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108161917.73a4c2c6.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 04:19:17PM -0800, Andrew Morton wrote:
> Seems not.  I think people were hoping that various nasties in there
> would go away.  We return to userspace with a kernel lock held??

Well, there might be nicer solutions, but for now we should revert the
broken commit to change the lock type.

