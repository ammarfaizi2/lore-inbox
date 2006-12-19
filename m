Return-Path: <linux-kernel-owner+w=401wt.eu-S932816AbWLSMSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbWLSMSP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 07:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932821AbWLSMSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 07:18:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35086 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932818AbWLSMSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 07:18:14 -0500
Subject: Re: Linux disk performance.
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Manish Regmi <regmi.manish@gmail.com>, Erik Mouw <mouw@nl.linux.org>,
       kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <458788D7.2070107@yahoo.com.au>
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
	 <1166431020.3365.931.camel@laptopd505.fenrus.org>
	 <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
	 <20061218130702.GA14984@gateway.home>
	 <652016d30612182222h7fde4ea5jbc0927c8ebeae76a@mail.gmail.com>
	 <458788D7.2070107@yahoo.com.au>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Tue, 19 Dec 2006 13:18:06 +0100
Message-Id: <1166530686.3365.1238.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 17:38 +1100, Nick Piggin wrote:
> Manish Regmi wrote:
> 
> > Nick Piggin:
> > 
> >> but
> >> they look like they might be a (HZ quantised) delay coming from
> >> block layer plugging.
> > 
> > 
> > Sorry i didn´t understand what you mean.
> 
> When you submit a request to an empty block device queue, it can
> get "plugged" for a number of timer ticks before any IO is actually
> started. This is done for efficiency reasons and is independent of
> the IO scheduler used.

however the O_DIRECT codepath unplugs the queues always immediately..



