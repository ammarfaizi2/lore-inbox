Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTD3Vq5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTD3Vq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:46:57 -0400
Received: from mx02.uni-tuebingen.de ([134.2.3.12]:39310 "EHLO
	mx02.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S262457AbTD3Vq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:46:56 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, dphillips@sistina.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
References: <Pine.LNX.4.44.0304300911420.16712-100000@home.transmeta.com>
	<1051734350.20270.28.camel@dhcp22.swansea.linux.org.uk>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 30 Apr 2003 23:59:09 +0200
In-Reply-To: <1051734350.20270.28.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <87vfwv4pg2.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.19.0.3; VDF 6.19.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Mer, 2003-04-30 at 17:16, Linus Torvalds wrote:
> > Clearly you're not going to make _one_ load to get fls, since having a 
> > 4GB lookup array for a 32-bit fls would be "somewhat" wasteful.
> 
> It ought to be basically the same as ffs because if I remember rightly 
> 
> ffs(x^(x-1)) == fls(x)

I don't think so. Maybe you are thinking of ffs(x) == fls(x & -x). So
you can calculate ffs with fls, but not easily the other way round.

-- 
	Falk
