Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbUKFMtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbUKFMtG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 07:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUKFMtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 07:49:06 -0500
Received: from cantor.suse.de ([195.135.220.2]:40633 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261377AbUKFMtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 07:49:02 -0500
Date: Sat, 6 Nov 2004 13:48:38 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Andreas Schwab <schwab@suse.de>,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, ak@suse.de,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
Message-ID: <20041106124838.GA16434@wotan.suse.de>
References: <20041103205655.GA5084@sgi.com> <20041104.105908.18574694.t-kochi@bq.jp.nec.com> <20041104040713.GC21211@wotan.suse.de> <20041104.135721.08317994.t-kochi@bq.jp.nec.com> <20041105160808.GA26719@sgi.com> <jevfcknty5.fsf@sykes.suse.de> <20041105164449.GC26719@sgi.com> <20041106115029.GB23305@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106115029.GB23305@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 11:50:29AM +0000, Christoph Hellwig wrote:
> On Fri, Nov 05, 2004 at 10:44:49AM -0600, Jack Steiner wrote:
> > > > +	for (i = 0; i < numnodes; i++)
> > > > +		len += sprintf(buf + len, "%s%d", i ? " " : "", node_distance(nid, i));
> > > 
> > > Can this overflow the space allocated for buf?
> > 
> > 
> > Good point. I think we are ok for now. AFAIK, the largest cpu count
> > currently supported is 512. That gives a max string of 2k (max of 3 
> > digits + space per cpu).
> 
> I always wondered why sysfs doesn't use the seq_file interface that makes
> life easier in the rest of them kernel.

Most fields only output a single number, and seq_file would be 
extreme overkill for that.

-Andi
