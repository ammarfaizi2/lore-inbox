Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbUKFLu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbUKFLu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 06:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbUKFLu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 06:50:58 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:18185 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261372AbUKFLuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 06:50:46 -0500
Date: Sat, 6 Nov 2004 11:50:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jack Steiner <steiner@sgi.com>
Cc: Andreas Schwab <schwab@suse.de>, Takayoshi Kochi <t-kochi@bq.jp.nec.com>,
       ak@suse.de, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Externalize SLIT table
Message-ID: <20041106115029.GB23305@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jack Steiner <steiner@sgi.com>, Andreas Schwab <schwab@suse.de>,
	Takayoshi Kochi <t-kochi@bq.jp.nec.com>, ak@suse.de,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20041103205655.GA5084@sgi.com> <20041104.105908.18574694.t-kochi@bq.jp.nec.com> <20041104040713.GC21211@wotan.suse.de> <20041104.135721.08317994.t-kochi@bq.jp.nec.com> <20041105160808.GA26719@sgi.com> <jevfcknty5.fsf@sykes.suse.de> <20041105164449.GC26719@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105164449.GC26719@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 10:44:49AM -0600, Jack Steiner wrote:
> > > +	for (i = 0; i < numnodes; i++)
> > > +		len += sprintf(buf + len, "%s%d", i ? " " : "", node_distance(nid, i));
> > 
> > Can this overflow the space allocated for buf?
> 
> 
> Good point. I think we are ok for now. AFAIK, the largest cpu count
> currently supported is 512. That gives a max string of 2k (max of 3 
> digits + space per cpu).

I always wondered why sysfs doesn't use the seq_file interface that makes
life easier in the rest of them kernel.

