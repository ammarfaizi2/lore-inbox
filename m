Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUBAXYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 18:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbUBAXYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 18:24:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42464 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265510AbUBAXYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 18:24:37 -0500
Date: Sun, 1 Feb 2004 15:22:41 -0800
From: "David S. Miller" <davem@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: jmorris@redhat.com, jakub@redhat.com, dparis@w3works.com,
       linux-kernel@vger.kernel.org, rspchan@starhub.net.sg
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch  
 pentium3,4
Message-Id: <20040201152241.485a6d8b.davem@redhat.com>
In-Reply-To: <401D6D38.3020009@tmr.com>
References: <Xine.LNX.4.44.0401301133350.16128-100000@thoron.boston.redhat.com>
	<20040130131400.13190af5.davem@redhat.com>
	<401D6D38.3020009@tmr.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Feb 2004 16:18:48 -0500
Bill Davidsen <davidsen@tmr.com> wrote:

> What didn't you like about Jakob's patch which avoids the 64 byte size 
> penalty?

Because it means memset'ing the thing every time the function is called.
And this function is called for every transform.
