Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTJQILb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 04:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbTJQILb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 04:11:31 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:25860 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263337AbTJQIL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 04:11:29 -0400
Date: Fri, 17 Oct 2003 09:11:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Colin Ngam <cngam@sgi.com>
Cc: Jes Sorensen <jes@trained-monkey.org>, Patrick Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com, jbarnes@sgi.com
Subject: Re: [PATCH] Altix I/O code cleanup
Message-ID: <20031017091125.A22492@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Colin Ngam <cngam@sgi.com>, Jes Sorensen <jes@trained-monkey.org>,
	Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	davidm@napali.hpl.hp.com, jbarnes@sgi.com
References: <3F872984.7877D382@sgi.com> <20031013095652.A25495@infradead.org> <yq0llrmncus.fsf@trained-monkey.org> <20031015135558.A8963@infradead.org> <yq0brshwcrx.fsf@trained-monkey.org> <3F8ECA11.C4281A8C@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F8ECA11.C4281A8C@sgi.com>; from cngam@sgi.com on Thu, Oct 16, 2003 at 11:40:49AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 11:40:49AM -0500, Colin Ngam wrote:
> > to panic() on a failed kmalloc because the data structure is required
> > for a core service, then doing ASSERT_ALWAYS isn't that unreasonable.
> 
> ASSERT_ALWAYS is used for many other cases other than just for
> testing NULL Pointers.  Whether you call ASSERT_ALWAYS or
> call panic with a message or just allow it to oops, a descriptive panic
> message can save some time.

Of course - but that's not that point.  You have to handle an out of
memory situtation propery because it  may happen all the time - you
should not panic at all.  The ASSERT_ALWAYS just confuses automatic
checker tools that help to find such conditions.

