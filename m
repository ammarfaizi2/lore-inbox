Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263910AbTDHDXQ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 23:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263911AbTDHDXP (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 23:23:15 -0400
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:40376 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S263910AbTDHDXN (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 23:23:13 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: linux-kernel@vger.kernel.org
Cc: mru@users.sourceforge.net
Subject: Re: Emulating insns on Alpha
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 08 Apr 2003 05:34:23 +0200
Message-ID: <871y0doe68.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.19.0.3; VDF 6.19.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are there any patches around that emulate the BWX instruction set on
> older Alpha CPUs, or should I write it myself?

There's an ancient one at
http://www.alphalinux.org/archives/axp-list/October1999/0500.html,
although it's probably easier to write it from scratch. I'd write the
whole thing in C, the trap is already so expensive that it's of no use
trying to be clever when emulating the particular instructions (except
when you replace the instruction with a jump to a stub, which seems
somewhat hairy, but feasible).

-- 
	Falk
