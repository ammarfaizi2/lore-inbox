Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbVHPKZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbVHPKZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 06:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbVHPKZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 06:25:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44180 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965195AbVHPKZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 06:25:59 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Cc: taka@valinux.co.jp, lkml.hyoshiok@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050816.191617.1025215458.hyoshiok@miraclelinux.com>
References: <20050816.131729.15816429.taka@valinux.co.jp>
	 <20050816.135425.719901536.hyoshiok@miraclelinux.com>
	 <1124171015.3215.0.camel@laptopd505.fenrus.org>
	 <20050816.191617.1025215458.hyoshiok@miraclelinux.com>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 12:25:50 +0200
Message-Id: <1124187950.3215.31.camel@laptopd505.fenrus.org>
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

On Tue, 2005-08-16 at 19:16 +0900, Hiro Yoshioka wrote:
> From: Arjan van de Ven <arjan@infradead.org>
> > > My code does nothing do it.
> > > 
> > > I need a volunteer to implement it.
> > 
> > it's actually not too hard; all you need is to use SSE and not MMX; and
> > then just store sse register you're overwriting on the stack or so...
> 
> oh, really? Does the linux kernel take care of
> SSE save/restore on a task switch?

not on kernel entry afaik.
However just save the register on the stack and put it back at the
end...


