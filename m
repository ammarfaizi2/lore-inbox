Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbVHYO4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbVHYO4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVHYO4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:56:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51342 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750978AbVHYO4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:56:14 -0400
Date: Thu, 25 Aug 2005 15:56:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to atomic_t
Message-ID: <20050825145608.GA15733@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Eric Dumazet <dada1@cosmosbay.com>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <20050824214610.GA3675@localhost.localdomain> <1124956563.3222.8.camel@laptopd505.fenrus.org> <430D8518.8020502@cosmosbay.com> <20050825090854.GA9740@infradead.org> <430D8CA3.3030709@cosmosbay.com> <20050825092322.GA9902@infradead.org> <430DA052.9070908@cosmosbay.com> <1124968309.5856.9.camel@npiggin-nld.site> <430DB8FA.4080009@cosmosbay.com> <430DDAF2.6030601@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430DDAF2.6030601@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 12:51:30AM +1000, Nick Piggin wrote:
> Eric Dumazet wrote:
> >Nick Piggin a ?crit :
> >
> 
> >>Would you just be able to add the atomic sysctl handler that
> >>Christoph suggested?
> >>
> >
> >Quite a lot of work indeed, and it would force to convert 3 int 
> >(nr_files, nr_free_files, max_files) to 3 atomic_t. I feel bad 
> >introducing a lot of sysctl rework for a tiny change (removing 
> >filp_count_lock)
> >
> 
> True, I didn't notice that.

Well, it would with a generic atomic_t handler.  With a special
handler for this situation it's not needed.

