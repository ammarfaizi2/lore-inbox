Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbTD3Mpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbTD3Mph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:45:37 -0400
Received: from mx01.arcor-online.net ([151.189.8.96]:27090 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id S262162AbTD3Mpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:45:35 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Wed, 30 Apr 2003 15:03:38 +0200
User-Agent: KMail/1.5.1
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
References: <200304300446.24330.dphillips@sistina.com> <87isswxmn0.fsf@student.uni-tuebingen.de>
In-Reply-To: <87isswxmn0.fsf@student.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304301503.38650.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 April 2003 13:14, Falk Hueffner wrote:
> gcc 3.4 will have a __builtin_ctz function which can be used for this.
> It will emit special instructions on CPUs that support it (i386, Alpha
> EV67), and use a lookup table on others, which is very boring, but
> also faster.

Actually, __builtin_clz:

  http://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html

Not having a gcc 2.4 handy, I couldn't test it, but I did notice that the 
built-in ffs is very fast.  Perhaps all such standard functions will end up 
as built-ins instead of kernel library functions, some very long time in the 
future.  If old compilers ever do finally fade away, that is.

It's somewhat annoying that __builtin_clz leaves the all-ones case dangling 
instead of returning -1.

Regards,

Daniel



