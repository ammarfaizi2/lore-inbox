Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269958AbTHSKRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 06:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269967AbTHSKRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 06:17:24 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:64517 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269958AbTHSKRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 06:17:22 -0400
Subject: Re: gcc -O3 and register usage
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030819001507.GA2015@werewolf.able.es>
References: <20030819001507.GA2015@werewolf.able.es>
Content-Type: text/plain
Message-Id: <1061288238.667.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 12:17:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-19 at 02:15, J.A. Magallon wrote:

> Does this mean that since PentiumPro gcc has one other register (%dl)
> available, and it uses it only at -O3 ?

AFAIK, the EDX 32-bit register is splitted in two 16-bit halves, being
the least significant half called DX which, at the sime time, is
splitted in two 8-bit halves of which the most significant is called DH,
while the least significant is called DL.

So, DL is not a new register, but the least significant 8-bits from the
EDX CPU register.

