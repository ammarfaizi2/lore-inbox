Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbTD3OmD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 10:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbTD3OmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 10:42:02 -0400
Received: from mx02.uni-tuebingen.de ([134.2.3.12]:28568 "EHLO
	mx02.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S262206AbTD3OmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 10:42:01 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dphillips@sistina.com, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
References: <Pine.LNX.4.44.0304300709300.7157-100000@home.transmeta.com>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 30 Apr 2003 16:53:54 +0200
In-Reply-To: <Pine.LNX.4.44.0304300709300.7157-100000@home.transmeta.com>
Message-ID: <87ptn4t4sd.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.19.0.3; VDF 6.19.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> Classic mistake. Lookup tables are only faster in benchmarks, they
> are almost always slower in real life. You only need to miss in the
> cache _once_ on the lookup to lose all the time you won on the
> previous one hundred calls.

It seems to me if you call the function so seldom the table drops out
of the cache, it is irrelevant how long it takes anyway.

> "Small and simple" is almost always better than the alternatives. 

Well, if a lookup table isn't "small and simple", I don't know what
is.

-- 
	Falk
