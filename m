Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVFMLY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVFMLY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 07:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVFMLY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 07:24:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18092 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261465AbVFMLYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 07:24:17 -0400
Subject: Re: Add pselect, ppoll system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       bert hubert <bert.hubert@netherlabs.nl>,
       Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       jnf <jnf@innocence-lost.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20050613111422.GT22349@devserv.devel.redhat.com>
References: <1118444314.4823.81.camel@localhost.localdomain>
	 <1118616499.9949.103.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
	 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>
	 <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>
	 <42AD2640.5040601@redhat.com> <20050613091600.GA32364@outpost.ds9a.nl>
	 <1118655702.2840.24.camel@localhost.localdomain>
	 <20050613110556.GA26039@infradead.org>
	 <20050613111422.GT22349@devserv.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 12:24:07 +0100
Message-Id: <1118661848.2840.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 07:14 -0400, Jakub Jelinek wrote:
> And if ppoll is added, the question is also what it's prototype should look like
> (i.e. have the suboptimal int timeout argument as poll(2), where you can
> only wait for less than a month or infinitely, or use const struct timespec *
> like pselect, or struct timeval * like select).

Eep -- I hadn't noticed that difference. Will update patch accordingly. 

The other documented difference (other than the signal mask bit) is that
pselect() is documented not to modify the timeout parameter. I'm not
sure whether I should preserve that difference, or not.

-- 
dwmw2

