Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVLNLzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVLNLzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVLNLzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:55:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9881 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932468AbVLNLzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:55:37 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       dhowells@redhat.com, cfriesen@nortel.com, torvalds@osdl.org,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <20051214115159.GG15804@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <15167.1134488373@warthog.cambridge.redhat.com>
	 <1134490205.11732.97.camel@localhost.localdomain>
	 <1134556187.2894.7.camel@laptopd505.fenrus.org>
	 <1134558188.25663.5.camel@localhost.localdomain>
	 <1134558507.2894.22.camel@laptopd505.fenrus.org>
	 <1134559470.25663.22.camel@localhost.localdomain>
	 <20051214033536.05183668.akpm@osdl.org>
	 <1134560671.2894.30.camel@laptopd505.fenrus.org>
	 <20051214115159.GG15804@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 12:55:08 +0100
Message-Id: <1134561309.2894.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 12:52 +0100, Andi Kleen wrote:
> > * mutex use is a candidate for a "spinaphore" treatment (unlike counting
> > semaphores)
> 
> I think that would be interesting experiment for page faults.
> But they actually use rwsems, not normal semaphores.

at least rwsems are only used as mutexes afaik... so those would just
end up being mutexes.. .and could thus do this too...

(I don't think anyone ever thought of doing a counting rwsem... at least
I sure hope so; the page fault one sure is a mutex)

