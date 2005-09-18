Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVIRGMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVIRGMu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 02:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVIRGMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 02:12:50 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5256
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751158AbVIRGMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 02:12:49 -0400
Date: Sat, 17 Sep 2005 23:12:47 -0700 (PDT)
Message-Id: <20050917.231247.29485761.davem@davemloft.net>
To: jmacbaine@gmail.com
Cc: ecashin@coraid.com, linux-kernel@vger.kernel.org
Subject: Re: aoe fails on sparc64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <3afbacad05091703103928bd33@mail.gmail.com>
References: <87u0glxhfw.fsf@coraid.com>
	<20050916.163554.79765706.davem@davemloft.net>
	<3afbacad05091703103928bd33@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim MacBaine <jmacbaine@gmail.com>
Date: Sat, 17 Sep 2005 12:10:17 +0200

> Was this patch meant to be applied to a fresh 2.6.13 kernel without
> any of Ed's patches? If so, I cannot confirm that this patch works.
> The aoe driver still reports a wrong size:

Please double check that you really ran with the patch
applied.  I even wrote a test kernel module that verified
that the bug was fixed by doing various unaligned 64-bit
loads and stores, both with and without endianness swapping.
It definitely failed before the patch, and definitely worked
with the patch.
