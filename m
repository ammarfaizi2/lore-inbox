Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSLMNPr>; Fri, 13 Dec 2002 08:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSLMNPr>; Fri, 13 Dec 2002 08:15:47 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:44756 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262804AbSLMNPq>; Fri, 13 Dec 2002 08:15:46 -0500
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: "Stephen Williams" <zhig9f05jg02@sneakemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux/alpha vs. 2.4.20 and ISO9660 vs long file names
References: <5095-51149@sneakemail.com>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 13 Dec 2002 14:22:57 +0100
In-Reply-To: <5095-51149@sneakemail.com>
Message-ID: <87vg1yjbny.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen Williams" <zhig9f05jg02@sneakemail.com> writes:

> For some reason, ls is having trouble with long file names on the
> disk. I follow with strace, and getdents64 is returning the right
> number of entries, but then ls tries to lstat a truncated name.  I
> can't say of the getdirent64 is trundating the name, but it seems
> likely.

This might be caused by a bug in stxcpy. Please try 2.4.210-pre1,
which contains a patch by Ivan Kokshaysky for this.

-- 
	Falk
