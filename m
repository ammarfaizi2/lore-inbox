Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVJ1KBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVJ1KBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 06:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVJ1KBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 06:01:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60103 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751186AbVJ1KA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 06:00:59 -0400
Subject: Re: [PATCH] [SECURITY, 2.4]  Avoid 'names_cache' memory leak with
	CONFIG_AUDITSYSCALL
From: Arjan van de Ven <arjan@infradead.org>
To: Horms <horms@verge.net.au>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051028092745.GL11045@verge.net.au>
References: <20051028092745.GL11045@verge.net.au>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 12:00:46 +0200
Message-Id: <1130493647.2800.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 18:27 +0900, Horms wrote:
> This is CAN-2005-3181, and a backport of
> 829841146878e082613a49581ae252c071057c23 from Linus's 2.6 tree to 2.4.
> 
> Original Description and Sign-Off:
> 
> Avoid 'names_cache' memory leak with CONFIG_AUDITSYSCALL
> 
> The nameidata "last.name" is always allocated with "__getname()", and
> should always be free'd with "__putname()".
> 
> Using "putname()" without the underscores will leak memory, because the
> allocation will have been hidden from the AUDITSYSCALL code.

> My sign off, indicating I think it applies to 2.4:


since there is no such thing as CONFIG_AUDITSYSCALL in any 2.4 kernel, I
really think this is entirely NOT relevant to 2.4.....


