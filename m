Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262186AbSJAS4d>; Tue, 1 Oct 2002 14:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbSJAS4c>; Tue, 1 Oct 2002 14:56:32 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:50959 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262224AbSJAS4W>; Tue, 1 Oct 2002 14:56:22 -0400
Date: Tue, 1 Oct 2002 20:01:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in
Message-ID: <20021001200142.A31614@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hugh Dickins <hugh@veritas.com>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <35FD2132190@vcnet.vc.cvut.cz> <Pine.LNX.4.44.0210011804001.1783-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210011804001.1783-100000@localhost.localdomain>; from hugh@veritas.com on Tue, Oct 01, 2002 at 06:14:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 06:14:04PM +0100, Hugh Dickins wrote:
> And looks to me like mprotect_fixup, in the merge case, may be passing
> an already freed vma to change_protection.  I'm not as confident about
> this patch as the earlier one, but I believe it's correct: please
> give it a try, and maybe Christoph will confirm or deny it.

Looks good.  My intial patch didn't do the the change_protection at all,
and it looks like the fix someone (akpm?) submitted wasn't exactly correct.

