Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVGGOMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVGGOMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 10:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVGGOMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 10:12:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11455 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261570AbVGGOLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 10:11:31 -0400
Date: Thu, 7 Jul 2005 15:11:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Michael Raymond <mraymond@sgi.com>
Subject: Re: [PATCH/RFC] Significantly reworked LTT core
Message-ID: <20050707141125.GA31025@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Karim Yaghmour <karim@opersys.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	LTT-Dev <ltt-dev@shafik.org>, Tom Zanussi <zanussi@us.ibm.com>,
	Robert Wisniewski <bob@watson.ibm.com>,
	Mathieu Desnoyers <compudj@krystal.dyndns.org>,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Michael Raymond <mraymond@sgi.com>
References: <42C60001.5050609@opersys.com> <20050702160445.GA29262@infradead.org> <42C703E4.2060202@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C703E4.2060202@opersys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2005 at 05:15:16PM -0400, Karim Yaghmour wrote:
> Christoph Hellwig wrote:
> > This code is rather pointless.  The ltt_mux is doing all the real
> > work and it's not included.  And while we're at it the layering for
> > it is wrong aswell - the ltt_log_event API should be implemented by
> > the actual multiplexer with what's in ltt_log_event now minus the
> > irq disabling becoming a library function.
> 
> Actually I kind of disagree here. Yes, you're partially right, ltt_mux
> is doing a lot of work, and it's not included. However, what work
> ltt_mux is doing is administrative and that's what was complained
> about a lot last time the ltt patches were included. So yes, I could
> provide a very basic ltt_mux that would instantiate a single relayfs
> channel and does no filtering whatsoever, but that would be
> insufficient for real usage. And if I provided a full mux, then we'd
> pretty much end up with the same code we had previously.

We're not gonna add hooks to the kernel so you can copile the same
horrible code you had before against it out of tree.  Do a sane demux
and submit it.

