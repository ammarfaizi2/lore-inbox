Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRANEE6>; Sat, 13 Jan 2001 23:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130645AbRANEEs>; Sat, 13 Jan 2001 23:04:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:63497 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130485AbRANEEi>; Sat, 13 Jan 2001 23:04:38 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
Date: 13 Jan 2001 20:04:05 -0800
Organization: Transmeta Corporation
Message-ID: <93r8fl$2nm$1@penguin.transmeta.com>
In-Reply-To: <7650.979387596@ocs3.ocs-net> <Pine.LNX.4.30.0101131413190.21182-100000@imladris.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0101131413190.21182-100000@imladris.demon.co.uk>,
David Woodhouse  <dwmw2@infradead.org> wrote:
>
>We don't need to overdesign it. get_module_symbol() basically provided
>this for us. The only thing really wrong with it was the lack of use
>count handling, which I fixed a while ago.

NO NO NO!

You miss _entirely_ the reason why "get_module_symbol()" was removed,
and why I will not _ever_ accept it coming back.

Hint #1: get_MODULE_symbol().

Hint #2: compiled in functionality.

The fact is, that get_module_symbol() was seriously and totally
mis-designed from the very beginning, and it was removed for THAT
reason, and it had nothing at all to do with the count handling.

So stop this discussion. It's not coming back. Live with the current
interfaces.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
