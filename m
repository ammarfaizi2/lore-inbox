Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWFXMLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWFXMLv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 08:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWFXMLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 08:11:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60321 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964791AbWFXMLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 08:11:50 -0400
Subject: Re: [PATCH] ext3_clear_inode(): avoid kfree(NULL)
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20060623142430.333dd666.akpm@osdl.org>
References: <200606231502.k5NF2jfO007109@hera.kernel.org>
	 <449C3817.2030802@garzik.org>  <20060623142430.333dd666.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 14:11:43 +0200
Message-Id: <1151151104.3181.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Because at that callsite, NULL is the common case.  We avoid a do-nothing
> function call most of the time.  It's a nano-optimisation.

but a function call is basically free, while an if () is not... even
with unlikely()...

sounds like a misoptimization to me.


