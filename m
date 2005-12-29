Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVL2Os3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVL2Os3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVL2Os2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:48:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30429 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750742AbVL2Os2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:48:28 -0500
Date: Thu, 29 Dec 2005 14:48:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] updates XFS mutex patch
Message-ID: <20051229144824.GC18833@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@trained-monkey.org>, Ingo Molnar <mingo@elte.hu>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <yq0zmmktbhk.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0zmmktbhk.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 05:59:35AM -0500, Jes Sorensen wrote:
> Hi,
> 
> Please find attached an updated patch for the XFS using MUTEX
> patch.
> 
> Note this is a replacement patch for the previous one.
> 
> Cheers,
> Jes
> 
> This patch switches XFS over to use the new mutex code directly as
> opposed to the previous workaround patch I posted earlier that avoided
> the namespace clash by forcing it back to semaphores. This falls in the
> 'works for me<tm>' category.

It's say just switch XFS to the one-arg mutex_init variant.

And ingo. please add the mutex_t typedef, analogue to spinlock_t it's a totally
opaqueue to the users type, so it really should be a typedef.  After that
the XFS mutex.h can just go away.

