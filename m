Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWAWSNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWAWSNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWAWSNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:13:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47832 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964858AbWAWSNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:13:18 -0500
Subject: Re: Rationale for RLIMIT_MEMLOCK?
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060123180106.GA4879@merlin.emma.line.org>
References: <20060123105634.GA17439@merlin.emma.line.org>
	 <1138014312.2977.37.camel@laptopd505.fenrus.org>
	 <20060123165415.GA32178@merlin.emma.line.org>
	 <1138035602.2977.54.camel@laptopd505.fenrus.org>
	 <20060123180106.GA4879@merlin.emma.line.org>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 19:13:13 +0100
Message-Id: <1138039993.2977.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 19:01 +0100, Matthias Andree wrote:
> On Mon, 23 Jan 2006, Arjan van de Ven wrote:
> 
> > yes the behavior is like this
> > 
> >                  root                non-root
> > before        about half of ram      nothing
> > after         all of ram             by default small, increasable
> > [...]
> > What application do you have in mind that broke by this relaxing of
> > rules?
> 
> This is not something I'd like to disclose here yet.
> 
> It is an application that calls mlockall(MCL_CURRENT|MCL_FUTURE) and
> apparently copes with mlockall() returning EPERM 

hmm... curious that mlockall() succeeds with only a 32kb rlimit....



