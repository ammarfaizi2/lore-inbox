Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWJBVEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWJBVEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWJBVEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:04:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60856
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965100AbWJBVEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:04:23 -0400
Date: Mon, 02 Oct 2006 14:04:37 -0700 (PDT)
Message-Id: <20061002.140437.78732307.davem@davemloft.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, axboe@suse.de
Subject: Re: linux/compat.h includes asm/signal.h causing problems
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061002135036.7bd1f76b.akpm@osdl.org>
References: <20061002.131414.74728780.davem@davemloft.net>
	<20061002135036.7bd1f76b.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Mon, 2 Oct 2006 13:50:36 -0700

> I don't know what a good fix is, really.  I guess one could put the
> declaration of sigset_from_compat() into its own header file and include
> that header from the right places.

I'm working on a patch that puts the compat signal bits into
include/asm-sparc64/compat_signal.h and adds the necessary
includes to a few *.c files under arch/sparc64 when needed.
