Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbUBRHpL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 02:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263793AbUBRHpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 02:45:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:60068 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263805AbUBRHpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 02:45:04 -0500
Subject: Re: ppc suspend rewrite using inline.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugang <hugang@soulinfo.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20040218153548.2690e905@localhost>
References: <20040218153548.2690e905@localhost>
Content-Type: text/plain
Message-Id: <1077090098.10665.121.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 18:41:39 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-18 at 18:35, Hugang wrote:
> Hi Ben:
> 
> I has finished rewriten the suspend code by inline, The swsusp2 works
> fine without any problem, But pmdisk can't works, The problem that's,
> when resume the current is not same as suspend.

I don't understand why you write. Looking at your code, I don't see
the point. By mixing C and assembly the way you do, and using those
horrible inline asm constructs, you are basically making the code
worse, less readable, and prone for bugs. I don't think you should
even try going into that direction, it makes no sense.

> I think the code can reuse by sleep.

Same

> I think turn off mmu copyback page is important, but I has looked x86
> resume code, it do not. 

Same

> Please take a look.

Please try to be clear.

> thanks.



