Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVBAABu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVBAABu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVBAAAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:00:40 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:30695
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261436AbVAaXzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:55:13 -0500
Date: Mon, 31 Jan 2005 15:46:07 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, ralf@linux-mips.org, davem@redhat.com, jgarzik@pobox.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] move dp83840.h to Documentation/
Message-Id: <20050131154607.70786f2c.davem@davemloft.net>
In-Reply-To: <20050131234158.GI21437@stusta.de>
References: <20050131234158.GI21437@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005 00:41:58 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> dp83840.h is included once but none of the definitions it contains is
> actually used.
> 
> Ralf Baechle wants that it stays as documentation, so this patch moves 
> it under Documentation/ .

No, let's kill this thing altogether.  The only driver in the world
using the CSCONFIG_* defines in there is the sunhme driver and it
defines it's own macros in drivers/net/sunhme.h  This header is more
than useless these days.

The header still exists in older trees and the revision history.
So people can still get to it there.
