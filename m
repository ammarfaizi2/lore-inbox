Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUC1JwS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 04:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUC1JwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 04:52:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35991 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262129AbUC1JwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 04:52:15 -0500
Date: Sun, 28 Mar 2004 01:51:56 -0800
From: "David S. Miller" <davem@redhat.com>
To: uaca@alumni.uv.es
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] PACKET_MMAP limit removal
Message-Id: <20040328015156.7c4a9bd7.davem@redhat.com>
In-Reply-To: <20040327184200.GA29991@pusa.informat.uv.es>
References: <20040322170520.GA3685@pusa.informat.uv.es>
	<20040327184200.GA29991@pusa.informat.uv.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Mar 2004 19:42:00 +0100
uaca@alumni.uv.es wrote:

> This patch also it removes the current limit on the number of frames
> PACKET_MMAP can hold. Currently the buffer can hold only
> 0.15 seconds at a 1 Gb/s in a 32 bit architecture, half
> this amount in a 64 bit machine.
>
> With this patch, PACKET_MMAP requires __less memory__
> to hold the buffer.
> 
> I have rearranged the most used members of struct packet_opt so they
> fit in a single cache line.
> 
> Any comment would be greatly appreciated

You're basically trading memory overhead for computational overhead.
And in this case I think that's fine.

I think your patch is fine and I'm going to apply it.
Can you cook up a 2.4.x version of this for me?

Thanks.
