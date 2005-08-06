Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVHFL4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVHFL4j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 07:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVHFL4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 07:56:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65183 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262191AbVHFL42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 07:56:28 -0400
Date: Sat, 6 Aug 2005 12:56:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8/8 Create MMU 2/3 level accessors in the sub-arch layer  (i386)
Message-ID: <20050806115619.GA1560@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>,
	linux-kernel@vger.kernel.org
References: <42F46558.9010202@vmware.com.suse.lists.linux.kernel> <p73wtmz1ekk.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73wtmz1ekk.fsf@bragg.suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2005 at 01:37:31PM +0200, Andi Kleen wrote:
> Zachary Amsden <zach@vmware.com> writes:
> 
> > i386 Transparent paravirtualization sub-arch patch #8.
> > 
> > Transparent paravirtualization support for MMU operations.
> > 
> > All operations which update live page table entries have been moved to the
> > sub-architecture layer.  Unfortunately, this required yet another parallel set
> > of pgtable-Nlevel-ops.h files, but this avoids the ugliness of having to use
> > #ifdef's all of the code.
> > 
> > This is pure code motion.  Anything else would be a bug.
> 
> I think that patch is really ugly - it makes hacking VM on i386
> even more painful than it already is because the convolutes the file
> structure even more. Hope it is not applied.

Especially as there's been no user shown for it, similar to all the other
ugly patches from vmware.

