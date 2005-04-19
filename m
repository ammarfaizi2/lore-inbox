Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVDSOvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVDSOvH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVDSOvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:51:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9710 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261580AbVDSOux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:50:53 -0400
Subject: Re: Development Model
From: Arjan van de Ven <arjan@infradead.org>
To: Chuck Wolber <chuckw@quantumlinux.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.60.0504182219360.6679@bailey.quantumlinux.com>
References: <Pine.LNX.4.60.0504182219360.6679@bailey.quantumlinux.com>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 16:50:48 +0200
Message-Id: <1113922249.6277.64.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 22:31 -0700, Chuck Wolber wrote:
> Greetings,
> 
> For months I have been reading as much as I can about the current 
> stable/unstable development model, but still have a question.
> 
> Has the Linux Kernel reached a point where the majority of developers feel 
> that (at least for now) no *MAJOR* "rip it out, stomp on it, burn it and 
> start over" parts of the kernel exist any longer? In other words, do you 
> feel that we're in a good place at this point and that incremental 
> improvements will rule the day until $COOL_IDEA comes along and requires a 
> refactoring of 2.x (where x is an odd number) porportions?


actually we have shown (and I like the model very much, it's a great way
to get many features production ready and in the hand of users/customers
really fast) that it doesn't take an odd number release branch to get
major changes in. Instead it takes careful design and sufficient testing
and review and most of the changes can go in anyway.

A good example is the 4 level page tables... we entirely changed how
pagetables worked (eg added another level) midway the 2.6 series and we
could because of the factors I wrote above. It even didn't majorly
destabilize the 2.6 tree to become unusable (although the change was
obviously not pain free for kernel architecture maintainers). 

The VM got replaced as well on the fly. The tty layer got half fixed and
seems to be in progress to be fixed even more. The scsi layer has gone
through an overhaul with the creation of transport classes etc etc. All
on the fly by doing careful design (eg stepwise), testing and review.

If we can do all that... what WOULD warrant a odd numbered release which
would be out of the hands of users for a long time (resulting in
features not being available for the users for a likewise long time,
which in turn means very little testing etc etc)

