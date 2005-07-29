Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVG2Ohc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVG2Ohc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 10:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVG2Ohc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 10:37:32 -0400
Received: from science.horizon.com ([192.35.100.1]:7230 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S262596AbVG2Ohb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 10:37:31 -0400
Date: 29 Jul 2005 10:37:26 -0400
Message-ID: <20050729143726.24317.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do the work)
Cc: rostedt@goodmis.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I guess when I get some time, I'll start testing all the i386 bitop
> functions, comparing the asm with the gcc versions.  Now could someone
> explain to me what's wrong with testing hot cache code. Can one
> instruction retrieve from memory better than others?

To add one to Linus' list, note that all current AMD & Intel chips
record instruction boundaries in L1 cache, either predecoding on
L1 cache load, or marking the boundaries on first execution.

The P4 takes it to an extreme, but P3 and K7/K8 do it too.

The result is that there are additional instruction decode limits
that apply to cold-cache code.
