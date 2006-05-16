Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWEPPsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWEPPsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWEPPsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:48:18 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:33154 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751274AbWEPPsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:48:17 -0400
Message-ID: <4469F43C.3080406@pobox.com>
Date: Tue, 16 May 2006 11:48:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: PATCH: Fix broken PIO with libata
References: <1147790393.2151.62.camel@localhost.localdomain> <4469F169.2050708@gmail.com>
In-Reply-To: <4469F169.2050708@gmail.com>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Is this agreed upon?  I tend to omit almost all unnecessary (by operator
> precedence) parenthesis, so in new EH and all other stuff, the "a && b &
> c" sort of lines are abundant.  If this is something that's agreed upon,
> I can do a clean sweep over those.


More parens == easier to review.  So
	a && b & c
should be
	a && (b & c)

to clearly delineate the separate expressions to the human eye, and also
make it clear to the reader that the '&' is intended, and not a typo
that should have been '&&'.

Anytime you see a long string of 'if' conditions, and the operators
vary, add parents for readability.

	Jeff


