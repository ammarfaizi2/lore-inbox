Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTD3NFB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 09:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbTD3NFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 09:05:01 -0400
Received: from mx03.uni-tuebingen.de ([134.2.3.13]:9858 "EHLO
	mx03.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S262165AbTD3NFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 09:05:00 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: dphillips@sistina.com
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
References: <200304300446.24330.dphillips@sistina.com>
	<87isswxmn0.fsf@student.uni-tuebingen.de>
	<200304301503.38650.dphillips@sistina.com>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 30 Apr 2003 15:17:13 +0200
In-Reply-To: <200304301503.38650.dphillips@sistina.com>
Message-ID: <87znm8w2ee.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.19.0.3; VDF 6.19.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <dphillips@sistina.com> writes:

> It's somewhat annoying that __builtin_clz leaves the all-ones case
> dangling instead of returning -1.

I assume you mean all-zero... Well, the semantics of the corresponding
instructions simply differ too much. clz(0) is 31 on some, 32 on some
others, and undefined on some more architectures. So nailing it down
would incur some performance penalty.

-- 
	Falk
