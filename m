Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266877AbUFYWHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266877AbUFYWHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUFYWHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:07:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16328 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266877AbUFYWF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:05:59 -0400
Date: Fri, 25 Jun 2004 15:05:32 -0700
From: "David S. Miller" <davem@redhat.com>
To: saiprathap <saiprathap@cc.usu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP-RST Vulnerability - Doubt
Message-Id: <20040625150532.1a6d6e60.davem@redhat.com>
In-Reply-To: <40DC9B00@webster.usu.edu>
References: <40DC9B00@webster.usu.edu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004 15:20:50 -0600
saiprathap <saiprathap@cc.usu.edu> wrote:

> I am a graduate research student majoring in the field of
> Computer Networking.As part of my research I have sorted out what FreeBSD has 
> done to overcome the TCP-RST vulnerability (by modifying the stack to accept 
> the RST packets only with the current + 1 sequence number and ignoring the 
> rest, even if their sequence numbers fall within the receiving window).
> 
> Could you kindly share your views regarding what Linux has done to its stack 
> to overcome this vulnerability as it will be of great help to my research.

We have done nothing, and there are no plans to implement any workaround
for this problem.

RFC2385 MD5 hashing support is going in soon, and for the application where
the vulnerability actually matters (BGP sessions between backbone routers)
MD5 clears that problem right up and they're all using MD5 protection already
anyways.
