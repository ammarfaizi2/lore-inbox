Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbVH3BGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbVH3BGS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 21:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVH3BGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 21:06:18 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:13767 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751433AbVH3BGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 21:06:18 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 16/16] Add hardware breakpoint support for i386 
In-reply-to: Your message of "Mon, 29 Aug 2005 09:12:08 MST."
             <resend.16.2982005.trini@kernel.crashing.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Aug 2005 11:06:04 +1000
Message-ID: <17337.1125363964@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2005 09:12:08 -0700, 
Tom Rini <trini@kernel.crashing.org> wrote:
>
>This adds hardware breakpoint support for i386.  This is not as well tested as
>software breakpoints, but in some minimal testing appears to be functional.

Hardware breakpoints must be per cpu, not global.  Also you will fall
over applications that are using gdb, because gdb uses the same
registers.  KDB has never really supported kernel hardware breakpoints,
they are hard to do without stamping on user space.

