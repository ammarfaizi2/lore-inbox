Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUDYWsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUDYWsA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 18:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUDYWsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 18:48:00 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:12561 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263664AbUDYWr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 18:47:58 -0400
Date: Mon, 26 Apr 2004 00:47:56 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Marcos B <marcosnospam@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: atkbd.c help !
Message-ID: <20040425224756.GC3040@pclin040.win.tue.nl>
References: <c66q9j$jvs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c66q9j$jvs$1@sea.gmane.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 11:49:44PM +0200, Marcos B wrote:

> I cannot run X.
> 
> after startx, I have this message in dmesg:
> 
> atkbd.c: unknown key released (transalted set 2, code 0x7a on 
> isa00060/serio0).
> atbkd.c: This is an XFree86 bug. It shouldn't access hardware directly.

This message is a kernel bug.
There was no key released, the code is not 0x7a, but there is an ACK
(code 0xfa) to some earlier command. There are many possible sources
of such a command, including BIOS, KVM switch, kbdrate, X and other programs.

So far I have only seen cases where such a message was harmless.
If things do not work for you, most likely the problem is elsewhere.

But you say "I cannot run X" without giving any indication of
what goes wrong for you.

