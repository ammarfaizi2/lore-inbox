Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbWFXQ4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbWFXQ4S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 12:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWFXQ4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 12:56:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37045 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750886AbWFXQ4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 12:56:18 -0400
Subject: Re: [PATCH] ext3_clear_inode(): avoid kfree(NULL)
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <449D6D07.9070901@goop.org>
References: <200606231502.k5NF2jfO007109@hera.kernel.org>
	 <449C3817.2030802@garzik.org> <20060623142430.333dd666.akpm@osdl.org>
	 <1151151104.3181.30.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0606240817170.23087@gandalf.stny.rr.com>
	 <1151152059.3181.37.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0606240833010.23318@gandalf.stny.rr.com>
	 <1151153177.3181.39.camel@laptopd505.fenrus.org>
	 <449D6D07.9070901@goop.org>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 18:55:55 +0200
Message-Id: <1151168155.3181.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 09:49 -0700, Jeremy Fitzhardinge wrote:
> Arjan van de Ven wrote:
> > nope none at all, at least not on x86/x86-64.
> > (in fact there is no way to help the prediction on those architectures
> > that actually works)
> >   
> The branch prediction hint prefixes (2e & 3e) don't work?

last I read they are both actively discouraged and ignored by all
"current" processors from both AMD and Intel. (see the optimization
guide PDF that Intel publishes)
Note: this is based on me reading public documentation, not on me
reading Intel internal stuff or asking the relevant chip architects, so
don't take this as a fully authoritative statement.


