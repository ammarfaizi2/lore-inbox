Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWFXOL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWFXOL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 10:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWFXOL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 10:11:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35764 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750714AbWFXOL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 10:11:56 -0400
Subject: Re: [PATCH] ext3_clear_inode(): avoid kfree(NULL)
From: Arjan van de Ven <arjan@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.58.0606240902390.23703@gandalf.stny.rr.com>
References: <200606231502.k5NF2jfO007109@hera.kernel.org>
	 <449C3817.2030802@garzik.org> <20060623142430.333dd666.akpm@osdl.org>
	 <1151151104.3181.30.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0606240817170.23087@gandalf.stny.rr.com>
	 <1151152059.3181.37.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0606240833010.23318@gandalf.stny.rr.com>
	 <1151153177.3181.39.camel@laptopd505.fenrus.org>
	 <1151153635.3181.41.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0606240902390.23703@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 16:11:35 +0200
Message-Id: <1151158295.3181.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The jne is expected to fail, so we will always continue to 0x13. Now is
> this a problem with x86/x86_64?

I'm not saying there is a problem; likely/unlikely do have an effect for
sure, it's just not a "make it free" thing....


