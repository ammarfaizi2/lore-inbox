Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVCIDk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVCIDk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 22:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVCIDk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 22:40:58 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:52452
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261470AbVCIDky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 22:40:54 -0500
Date: Tue, 8 Mar 2005 19:40:17 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: Fix suspend/resume problems with b44
Message-Id: <20050308194017.195691f4.davem@davemloft.net>
In-Reply-To: <20050308215537.GD24188@elf.ucw.cz>
References: <20050308094655.GA16775@elf.ucw.cz>
	<20050308101739.371968be.davem@davemloft.net>
	<20050308215537.GD24188@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 22:55:37 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Any idea what to do there? I'd say that request_irq is very unlikely
> to fail given that it worked okay before suspend...

What you have is fine for now.

It is just a general issue that ->resume() has no way to cleanly
fail.
