Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318806AbSHLUGJ>; Mon, 12 Aug 2002 16:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318810AbSHLUGJ>; Mon, 12 Aug 2002 16:06:09 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:6407 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318806AbSHLUGI>; Mon, 12 Aug 2002 16:06:08 -0400
Date: Mon, 12 Aug 2002 21:09:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1 of 2] Scalable statistics counters
Message-ID: <20020812210952.A17329@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20020812183524.B1992@in.ibm.com> <20020812144605.A4595@infradead.org> <20020813013546.A7819@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020813013546.A7819@in.ibm.com>; from dipankar@in.ibm.com on Tue, Aug 13, 2002 at 01:35:46AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 01:35:46AM +0530, Dipankar Sarma wrote:
> Suppose I use seq_file interface and not put all statctrs in one /proc
> file, how do I associate the statctr data structure with the /proc
> inode ? IOW, how do I quickly get the statctr_pentry corresponding to the
> counter in statctr_open() ?

Stuff it into the ->private member of struct seq_file in your open method.
BTW, what about renaming statctr_pentry to statctr_group?

