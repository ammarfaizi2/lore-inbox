Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUBQG3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbUBQG3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:29:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14208 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266052AbUBQG3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:29:39 -0500
Date: Mon, 16 Feb 2004 22:29:34 -0800
From: "David S. Miller" <davem@redhat.com>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: 2.4.24 link err for sparc64
Message-Id: <20040216222934.498910c1.davem@redhat.com>
In-Reply-To: <20040216072928.GA30923@net-ronin.org>
References: <20040216072928.GA30923@net-ronin.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004 23:29:29 -0800
carbonated beverage <ramune@net-ronin.org> wrote:

> I ripped out sysctl support from a 2.4.24 kernel (stock
> tarball from ftp.*.*.kernel.org) and the final link failed
> with:
> 
> arch/sparc64/kernel/kernel.o(.text+0x19750): In function `sys32_sysctl':
> : undefined reference to `do_sysctl'

-ENOSYS is the right error to return, to be consistent with what
kernel/sysctl.c itself does in this case.

Thanks for the report, I'll push the fix around.
