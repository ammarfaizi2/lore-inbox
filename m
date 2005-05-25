Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVEYOrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVEYOrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 10:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVEYOrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 10:47:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43699 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261365AbVEYOrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 10:47:19 -0400
Subject: Re: Add "FORTIFY_SOURCE" to the linux kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: arjan@pentafluge.infradead.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <4294891E.4070702@vc.cvut.cz>
References: <20050525084332.GA16865@pentafluge.infradead.org>
	 <4294891E.4070702@vc.cvut.cz>
Content-Type: text/plain
Date: Wed, 25 May 2005 16:47:16 +0200
Message-Id: <1117032436.6010.76.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
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

On Wed, 2005-05-25 at 16:18 +0200, Petr Vandrovec wrote:
> Hello,
>    how is this going to comply with rule that no existing symbols will be turned
> into GPLONLY symbols, as stated by Linus couple of time, and mentioned for example
> at http://www.tux.org/lkml/#s1-19 ?  To me it looks that no non-GPL module can work
> on such kernel anymore, as memcpy/strcpy/... functions now, although themselves non-GPL
> accessible (but inline...), depend on GPLONLY symbols.  Can you explain this to
> me?

then don't set the config option in your kernel, and you don't get
these. Also memcpy_chk() is not an existing function, it is a new one.
This is by no means mandatory.

Or, alternatively, in your module UNDEF the config option before
including these headers.


>    And if you think that it is right thing to do, would not it be simpler for
> everybody changing module loader so it just refuses to load non-GPL modules ?
> Final functionality would be same in both cases...

that is not correct.

