Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVHHKFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVHHKFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVHHKFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:05:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44264 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750791AbVHHKFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:05:39 -0400
Subject: Re: [PATCH 00/14] GFS
From: Arjan van de Ven <arjan@infradead.org>
To: David Teigland <teigland@redhat.com>
Cc: Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <20050808095747.GD13951@redhat.com>
References: <20050802071828.GA11217@redhat.com>
	 <84144f0205080223445375c907@mail.gmail.com>
	 <20050808095747.GD13951@redhat.com>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 12:05:25 +0200
Message-Id: <1123495525.3245.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Mon, 2005-08-08 at 17:57 +0800, David Teigland wrote:
> > 
> > Please drop the extra braces.
> 
> Here and elsewhere we try to keep unused stuff off the stack.  Are you
> suggesting that we're being overly cautious, or do you just dislike the
> way it looks?

nice theory. In practice gcc 3.x still adds up all the stack space
anyway and as long as gcc 3.x is a supported kernel compiler, you can't
depend on this. Also.. please favor readability. gcc is getting smarter
about stack use nowadays, and {}'s shouldn't be needed to help it, it
tracks liveness of variables already.



