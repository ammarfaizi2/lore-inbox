Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVAYW7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVAYW7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVAYW6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:58:41 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:22706 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262207AbVAYW4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:56:14 -0500
Subject: Re: [Fwd: TASK_SIZE is variable.]
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050125224654.GA30150@infradead.org>
References: <20050125224654.GA30150@infradead.org>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 22:55:59 +0000
Message-Id: <1106693759.783.89.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 22:46 +0000, Christoph Hellwig wrote:
> > Bad things can happen if a 32-bit process is the last user of a 64-bit
> > mm. TASK_SIZE isn't a constant, and we can end up clearing page tables
> > only up to the 32-bit TASK_SIZE instead of all the way. We should
> > probably double-check every instance of TASK_SIZE or USER_PTRS_PER_PGD
> > for this kind of problem.
> 
> Or better get rid of TASK_SIZE completely.  Having something that looks
> like a constant change depending on the user process is a bad idea.

Yeah, that's possibly a sane plan.

-- 
dwmw2


