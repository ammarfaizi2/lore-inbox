Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268664AbUHaXGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268664AbUHaXGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268674AbUHaW6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:58:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:18644 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269099AbUHaW6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:58:02 -0400
Date: Tue, 31 Aug 2004 16:01:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch]  kill __always_inline
Message-Id: <20040831160113.00ac2a06.akpm@osdl.org>
In-Reply-To: <20040831225244.GY3466@fs.tum.de>
References: <20040831221348.GW3466@fs.tum.de>
	<20040831153649.7f8a1197.akpm@osdl.org>
	<20040831225244.GY3466@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> If you want to change inline at some point, you will have to audit all  
> users of inline anyway - so why bother if you don't intend to change 
> inline in the forseeable future?

inline was set to do `always inline' when it was discovered that new gcc
was doing dopey things.  If gcc gets fixed then we don't need that any more.

But functions which *must* be inlined should be marked __always_inline
regardless of anything else.
