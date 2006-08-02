Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWHBQOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWHBQOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWHBQOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:14:15 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:53454 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932073AbWHBQOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:14:14 -0400
Date: Wed, 2 Aug 2006 18:14:03 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] at91_serial: Fix break handling
Message-ID: <20060802181403.32169f00@cad-250-152.norway.atmel.com>
In-Reply-To: <20060802151741.GB32102@flint.arm.linux.org.uk>
References: <11545303083273-git-send-email-hskinnemoen@atmel.com>
	<11545303082669-git-send-email-hskinnemoen@atmel.com>
	<11545303083943-git-send-email-hskinnemoen@atmel.com>
	<20060802151741.GB32102@flint.arm.linux.org.uk>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006 16:17:41 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:


> 1. Effectively, this just ignores every second break status.  We've
> no idea _which_ break interrupt is going to be ignored.

Good point. Would it be better if I forced break_active to zero after
some timeout?

Come to think about it, it's really strange that there's a single bit
indicating both start-of-break and end-of-break. I'll see if I can find
a way to tell the difference.

> 2. it breaks break handling.  uart_handle_break returns a value for a
>    reason.  Use it - don't unconditionally ignore the received
> character.

Ok, I'll fix it.

Out of curiosity, why does it return a value? ;)

Håvard
