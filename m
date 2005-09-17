Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbVIQKKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVIQKKU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 06:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbVIQKKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 06:10:20 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:14438 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751035AbVIQKKT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 06:10:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d2UKzQKNc9/+GD8rBLjgnUpRQ4gJvUI0iFemITJe0iLutoK2S5alG0ss0Ur4wlv3l2aLg1Z4MT/MUaMu/0R+HNVreL2RGu23kP3MnMeLrIzbq6K28CHaS/N4dTpeu56OMGO69Y08dsEOUIwzJ7lcIKR/jAgpGNVPQ8T7nJ5Mooc=
Message-ID: <3afbacad05091703103928bd33@mail.gmail.com>
Date: Sat, 17 Sep 2005 12:10:17 +0200
From: Jim MacBaine <jmacbaine@gmail.com>
Reply-To: jmacbaine@gmail.com
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: aoe fails on sparc64
Cc: ecashin@coraid.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050916.163554.79765706.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3afbacad0508310630797f397d@mail.gmail.com>
	 <87u0glxhfw.fsf@coraid.com>
	 <20050916.163554.79765706.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/05, David S. Miller <davem@davemloft.net> wrote:

> This patch should fix the bug.
> 
> diff --git a/arch/sparc64/kernel/una_asm.S b/arch/sparc64/kernel/una_asm.S
[..]
> diff --git a/arch/sparc64/kernel/unaligned.c b/arch/sparc64/kernel/unaligned.c
[..]

Was this patch meant to be applied to a fresh 2.6.13 kernel without
any of Ed's patches? If so, I cannot confirm that this patch works.
The aoe driver still reports a wrong size:

sunny:~# modprobe aoe
aoe: aoe_init: AoE v2.6-10 initialised.
 etherd/e0.0: unknown partition table
aoe: 0011xxxxxxxx e0.0 v4000 has 7441392446501552128 sectors

The exported file has got a size of 19088743 sectors.

Regards,
Jim
