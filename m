Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbVL0OXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVL0OXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 09:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVL0OXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 09:23:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21472 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932328AbVL0OXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 09:23:33 -0500
Subject: Re: Is there any Buffer overflow attack mechanism that can break
	a	vulnerable server without breaking the ongoing connection?
From: Arjan van de Ven <arjan@infradead.org>
To: "nashleon@gmx.de" <nashleon@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43B14D1A.8010608@gmx.de>
References: <4ae3c140512261247p612146f5w6ad8bf474f4ebfd5@mail.gmail.com>
	 <1135630282.3910.8.camel@laptopd505.fenrus.org>  <43B14D1A.8010608@gmx.de>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 15:23:30 +0100
Message-Id: <1135693411.2926.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.4 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 12:18 -0200, nashleon@gmx.de wrote:
> Arjan van de Ven escreveu:
> 
> >buffer overflows do not break connections, and as such I think you are
> >out of luck.
> >Having said that.. on modern linux distros it's pretty hard to do a
> >buffer overflow exploit nowadays (NX[1] to make stacks non-executable,
> >randomisations, compiler based detection (via FORTIFY_SOURCE and/or
> >-fstackprotector)... add all those together and it's certainly not easy
> >to do this....
> >
> >
> >
> >[1] or emulations of NX such as segment limits techniques
> >
> >  
> >
> 
> Hello!
> 
> Locally is very simple to exploit buffer overflows in the linux kernel. 

sure kernel space is a whole different kettle of fish. The good news
there however is that in kernel space it's rather rare to work with
buffers on the stack (by virtue of only having a really tiny stack in
the first place). Not impossible but at least rare.


