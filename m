Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVLMOoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVLMOoe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVLMOoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:44:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20916 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964943AbVLMOoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:44:34 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Arjan van de Ven <arjan@infradead.org>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <439EDC3D.5040808@nortel.com>
References: <1134479118.11732.14.camel@localhost.localdomain>
	 <dhowells1134431145@warthog.cambridge.redhat.com>
	 <3874.1134480759@warthog.cambridge.redhat.com>
	 <439EDC3D.5040808@nortel.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 15:44:22 +0100
Message-Id: <1134485062.9814.0.camel@laptopd505.fenrus.org>
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

On Tue, 2005-12-13 at 08:35 -0600, Christopher Friesen wrote:
> David Howells wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> >>It seems to me it would be far far saner to define something like
> >>
> >>	sleep_lock(&foo)
> >>	sleep_unlock(&foo)
> >>	sleep_trylock(&foo)
> > 
> > Which would be a _lot_ more work. It would involve about ten times as many
> > changes, I think, and thus be more prone to errors.
> 
> "lots of work" has never been a valid reason for not doing a kernel 
> change...
> 
> In this case, introducing a new API means the changes can be made over time.

in this case, doing this change gradual I think is a mistake. We should
do all of the in-kernel code at least... 

