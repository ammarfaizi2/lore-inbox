Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTD3Nt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 09:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTD3Nt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 09:49:57 -0400
Received: from mx01.arcor-online.net ([151.189.8.96]:28292 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id S262176AbTD3Nt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 09:49:56 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Wed, 30 Apr 2003 16:07:59 +0200
User-Agent: KMail/1.5.1
Cc: <linux-kernel@vger.kernel.org>
References: <200304300446.24330.dphillips@sistina.com> <200304301503.38650.dphillips@sistina.com> <87znm8w2ee.fsf@student.uni-tuebingen.de>
In-Reply-To: <87znm8w2ee.fsf@student.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304301607.59835.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30 Apr 03 15:17, Falk Hueffner wrote:
> Daniel Phillips <dphillips@sistina.com> writes:
> > It's somewhat annoying that __builtin_clz leaves the all-ones case
> > dangling instead of returning -1.
>
> I assume you mean all-zero...

:-)

> Well, the semantics of the corresponding
> instructions simply differ too much. clz(0) is 31 on some, 32 on some
> others, and undefined on some more architectures. So nailing it down
> would incur some performance penalty.

It would only penalize stupidly broken architectures; it would help the ones 
that got it right.  It's hard to imagine how a sane person could think the 
result of clz((u32)0) should be other than 32.

Sigh.

Regards,

Daniel

