Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWGCR1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWGCR1Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWGCR1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:27:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52624 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751214AbWGCR1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:27:15 -0400
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, mingo@elte.hu,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607031007421.12404@g5.osdl.org>
References: <1151885928.24611.24.camel@localhost.localdomain>
	 <20060702173527.cbdbf0e1.akpm@osdl.org>
	 <Pine.LNX.4.64.0607031007421.12404@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 19:27:07 +0200
Message-Id: <1151947627.3108.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 10:13 -0700, Linus Torvalds wrote:
>         #ifndef xyzzy
>         #define zyzzy() /* empty */
>         #endif
> 

now if you write it as

#define zyzzy() do { ; } while (0)

it even works in a

if (foo())
	zyzzy();
bar();

scenario 

(I know you know that, just pointing that out before people copy your
example :-)

