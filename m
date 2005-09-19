Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbVISSVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVISSVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVISSVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:21:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9358
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932550AbVISSVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:21:50 -0400
Date: Mon, 19 Sep 2005 11:21:59 -0700 (PDT)
Message-Id: <20050919.112159.55767801.davem@davemloft.net>
To: ecashin@coraid.com
Cc: linux-kernel@vger.kernel.org, jmacbaine@gmail.com
Subject: Re: aoe fails on sparc64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <87slw1b0fz.fsf@coraid.com>
References: <87u0glxhfw.fsf@coraid.com>
	<20050916.163554.79765706.davem@davemloft.net>
	<87slw1b0fz.fsf@coraid.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed L Cashin <ecashin@coraid.com>
Date: Mon, 19 Sep 2005 10:24:00 -0400

>   1) Passing le64_to_cpup an unaligned pointer is "OK" and within the
>      intended use of the function.  I'm having trouble finding whether
>      this is documented somewhere.
> 
>   2) These new changes to the sparc64 unaligned access fault handling
>      will make it OK to leave the aoe driver the way it is in the
>      mainline kernel.

Both #1 and #2 are true.

Although it's very much discouraged to dereference unaligned pointers,
especially in performance critical code (which this AOE case is not,
thankfully), because performance will be really bad as the trap
handler has to fix up the access on RISC platforms.
