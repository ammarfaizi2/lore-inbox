Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUH3HZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUH3HZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUH3HZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:25:17 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:42140 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264396AbUH3HZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 03:25:13 -0400
Date: Mon, 30 Aug 2004 00:24:22 -0700
From: "David S. Miller" <davem@davemloft.net>
To: andersen@codepoet.org
Cc: mmazur@kernel.pl, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.8.1
Message-Id: <20040830002422.4b634c6c.davem@davemloft.net>
In-Reply-To: <20040830062856.GA10475@codepoet.org>
References: <200408292232.14446.mmazur@kernel.pl>
	<20040830062856.GA10475@codepoet.org>
Organization: DaveM Loft Enterprises
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004 00:28:56 -0600
Erik Andersen <andersen@codepoet.org> wrote:

> I really do not like this change.  Since PAGE_SIZE has always
> been a constant, the change you have made is likely to break a
> fair amount of code, basically any code doing stuff like:

It has never been a constant, and any portable piece of
software needs to evaluate it not at compile time.

When I first did the sparc64 port, the biggest source of
portability problems was of the "uses PAGE_SIZE in some way"
nature.

This is a positive change, we should break the build of these
apps and thus get them fixed.
