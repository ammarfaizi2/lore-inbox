Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbVEHAcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbVEHAcH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 20:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVEHAcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 20:32:06 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:9660 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262768AbVEHAcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 20:32:03 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: disabling "double-calling" of level-driven interrupts
Date: Sun, 08 May 2005 10:31:52 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <62nq71hrnt1tirf8lgap5469bo5lstp18v@4ax.com>
References: <20050507203212.GG17194@lkcl.net>
In-Reply-To: <20050507203212.GG17194@lkcl.net>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 May 2005 21:32:12 +0100, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:

>something he said made me go "twitch" - the infrastructure involving
>interrupts in the 2.6 kernel - that they can be called TWICE.
>
>well, that's exactly what i am seeing happen - even when the
>relevant INTSR1 bit is clear.
>
>at the top of the interrupt service routine, i double-check the
>bit of INTSR1 that caused the interrupt.
>
>i find it to be clear.
>
>doing an immediate return IRQ_HANDLED results in working code,
>whereas before, the behaviour of our LCD was utterly unreliable.

Isn't that the whole idea of level triggered interrupts?  Your 
device may not be the one asserting IRQ, if the IRQ is not yours, 
let it go and something else will check to see if the IRQ is theirs.

--Grant.

