Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUCWCEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUCWCEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:04:13 -0500
Received: from zero.aec.at ([193.170.194.10]:8 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261913AbUCWCEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:04:12 -0500
To: George Anzinger <george@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]Call frame debug info for 2.6 kernel
References: <1AR5s-75I-27@gated-at.bofh.it> <1CHY0-1Uw-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 23 Mar 2004 03:04:10 +0100
In-Reply-To: <1CHY0-1Uw-9@gated-at.bofh.it> (George Anzinger's message of
 "Tue, 23 Mar 2004 01:30:13 +0100")
Message-ID: <m3n0685nfp.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> writes:

> This patch adds call frame debug record generation for entry.S frames.

[...]

Sorry, but that's quite ugly and will be hard to maintain (kinda like
maintaining an own assembler on your own) I think it would be far
better to require recent binutils for DEBUG_INFO builds and use the
.cfi_* mnemonics. They make dwarf2 code *much* simpler and cleaner.

Overall I think it's a good idea to add full dwarf2 annotation to
the i386 kernel, but not without assembler please.

-Andi

