Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVCVWRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVCVWRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVCVWQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:16:39 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:36228
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262153AbVCVWNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:13:41 -0500
Date: Tue, 22 Mar 2005 14:08:57 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] drivers/net/tg3.c: remove dead code
Message-Id: <20050322140857.34c55ce6.davem@davemloft.net>
In-Reply-To: <20050322220243.GQ1948@stusta.de>
References: <20050322220243.GQ1948@stusta.de>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 23:02:43 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The Coverity checker discovered that i never gets any value different 
> from 0 assigned.
> 
> I do not claim that this patch is correct, but if it isn't correct the 
> bug is that i never gets assigned any value.

Indeed, 'i' needs to be incremented at the end of the loop
basic block.

Good catch.
