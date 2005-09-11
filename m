Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVIKJAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVIKJAn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 05:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVIKJAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 05:00:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55949 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932466AbVIKJAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 05:00:43 -0400
Date: Sun, 11 Sep 2005 10:00:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Roland Dreier <rolandd@cisco.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git pull] InfiniBand updates
Message-ID: <20050911090022.GA4841@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wedgwood <cw@f00f.org>, Roland Dreier <rolandd@cisco.com>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org
References: <523bocedcb.fsf@cisco.com> <20050911030345.GA14593@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911030345.GA14593@taniwha.stupidest.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 08:03:45PM -0700, Chris Wedgwood wrote:
> On Sat, Sep 10, 2005 at 04:02:12PM -0700, Roland Dreier wrote:
> 
> >  include/rdma/ib_cm.h                      |    1
> >  include/rdma/ib_mad.h                     |   21 ++
> >  include/rdma/ib_sa.h                      |   31 +++
> >  include/rdma/ib_user_cm.h                 |   72 +++++++
> >  include/rdma/ib_user_verbs.h              |   21 ++
> 
> Do these really need to be here?  if we really must merge RDMA can we
> not hide these headers in drivers/inifiniband for now?

No.  They've been there before, but it's just wrong.  This stuff is
kernel-wide interfaces and having them under drivers/ was wrong to start
with.
