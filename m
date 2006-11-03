Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753373AbWKCR31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbWKCR31 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbWKCR31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:29:27 -0500
Received: from raven.upol.cz ([158.194.120.4]:1170 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1753373AbWKCR30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:29:26 -0500
Date: Fri, 3 Nov 2006 18:36:09 +0100
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, Gabriel C <nix.or.die@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: New filesystem for Linux
Message-ID: <20061103173609.GA17080@flower.upol.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <454A71EB.4000201@googlemail.com> <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz> <20061102174149.3578062d.akpm@osdl.org> <20061103171443.GA16912@flower.upol.cz> <Pine.LNX.4.64.0611031808280.15472@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611031808280.15472@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 06:09:39PM +0100, Mikulas Patocka wrote:
> >In gmane.linux.kernel, you wrote:
> >[]
> >>From: Andrew Morton <akpm@osdl.org>
> >>
> >>As Mikulas points out, (1 << anything) won't be evaluating to zero.
> >
> >How about integer overflow ?
> 
> C standard defines that shifts by more bits than size of a type are 
> undefined (in fact 1<<32 produces 1 on i386, because processor uses only 5 
> bits of a count).
,--
|#include <stdio.h>
|int main(void) {
|	unsigned int b = 1;
|
|	printf("%u\n", (1 << 33));
|	printf("%u\n", (b << 33));
|	return 0;
|}
|$ gcc bit.c && ./a.out
`--

There *is* difference, isn't it?

> Mikulas
____
