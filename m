Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbTAFSvp>; Mon, 6 Jan 2003 13:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbTAFSvo>; Mon, 6 Jan 2003 13:51:44 -0500
Received: from air-2.osdl.org ([65.172.181.6]:39055 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264666AbTAFSvm>;
	Mon, 6 Jan 2003 13:51:42 -0500
Date: Mon, 6 Jan 2003 10:57:01 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Tom Rini <trini@kernel.crashing.org>
cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: [PATCH] configurable LOG_BUF_SIZE
In-Reply-To: <20030106185025.GC796@opus.bloom.county>
Message-ID: <Pine.LNX.4.33L2.0301061053130.15416-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2003, Tom Rini wrote:

| On Thu, Jan 02, 2003 at 03:09:17PM -0800, Randy.Dunlap wrote:
|
| > This patch to 2.5.54 make LOG_BUF_LEN a configurable option.
| > Actually its shift value is configurable, and that keeps it
| > a power of 2.
|
| Erm, why not just prompt for an int, slightly change the help wording,
| and then just give a default int value directly.
|
| Flexibility is good for everyone.

Sure, I like that, but LOG_BUF_LEN must be a power of 2 (currently)
and I was trying not to rewrite that circular buffer code, that's all.
However, I will if that's desirable.

And kconfig doesn't have a way to enforce the selected value...

I asked Roman about 2-3 weeks ago about some way to enforce ranges on
config values, e.g. (but that wouldn't affect powers of 2).

Linus also told me that he's not crazy about this change.
I just want the LOG_BUF_LEN available outside of kernel/printk.c...

-- 
~Randy

