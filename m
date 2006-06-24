Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWFXTdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWFXTdB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 15:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWFXTdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 15:33:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15514 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751058AbWFXTdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 15:33:00 -0400
Subject: Re: [PATCH] x86: cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0606241218510.6483@g5.osdl.org>
References: <200606231501.k5NF1B79002899@hera.kernel.org>
	 <1151160152.3181.59.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0606241218510.6483@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 21:32:56 +0200
Message-Id: <1151177576.3181.79.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 12:21 -0700, Linus Torvalds wrote:
> 
> On Sat, 24 Jun 2006, Arjan van de Ven wrote:
> > 
> > while this patch will reduce the number of cycles spent in the kernel,
> > it's just pushing the cache miss to userspace (by virtue of doing a
> > cache flush effectively)... is this really the right thing? The total
> > memory bandwidth will actually increase with this patch if you're
> > unlucky (eg if userspace decides to write to this memory eventually)....
> 
> No. It's for copying _from_ user space, ie a "write()" system call.

eh DOH

never mind



