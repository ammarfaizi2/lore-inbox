Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVACOPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVACOPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 09:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVACOPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 09:15:43 -0500
Received: from canuck.infradead.org ([205.233.218.70]:27147 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261455AbVACOPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 09:15:35 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>
In-Reply-To: <20050103140359.GA19976@infradead.org>
References: <1104374603.9732.32.camel@krustophenia.net>
	 <20050103140359.GA19976@infradead.org>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 15:15:27 +0100
Message-Id: <1104761727.4192.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 14:03 +0000, Christoph Hellwig wrote:
> On Wed, Dec 29, 2004 at 09:43:22PM -0500, Lee Revell wrote:
> > The realtime LSM has been previously explained on this list.  Its
> > function is to allow selected nonroot users to run RT tasks.  The most
> > common application is low latency audio with JACK, http://jackit.sf.net.
> > 
> > Several people have reported that 2.6.10 is the best kernel yet for
> > audio latency, see
> > http://ccrma-mail.stanford.edu/pipermail/planetccrma/2004-December/007341.html.    If the realtime LSM were merged, then this would be the last step to making low latency audio work well with the stock kernel.
> > 
> > We (the authors and the Linux audio community) would like to request its
> > inclusion in the next -mm release, with the eventual goal of having it
> > in mainline.
> > 
> > This is identical to the last version Jack O'Quin posted (but didn't cc:
> > Andrew, or make clear that we would like this added to -mm), so I
> > preserved his Signed-Off-By.
> 
> This is far too specialized.  And option to the capability LSM to grant 
> capabilities to certain uids/gids sounds like the better choise - and
> would also allow to get rid of the magic hugetlb uid horrors.
those can go away anyway now that there is an rlimit to achieve the
exact same thing.....

I can see the point of making an rlimit like thing instead for both the
nice levels allowed and maybe the "can do rt" bit


