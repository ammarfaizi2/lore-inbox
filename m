Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbUCRRr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 12:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbUCRRr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 12:47:57 -0500
Received: from ns.suse.de ([195.135.220.2]:24025 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262812AbUCRRrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 12:47:55 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: fcntl error
References: <7051.1079628297@redhat.com>
	<Pine.LNX.4.58.0403180923190.880@ppc970.osdl.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: You must be a CUB SCOUT!!  Have you made your MONEY-DROP today??
Date: Thu, 18 Mar 2004 18:47:51 +0100
In-Reply-To: <Pine.LNX.4.58.0403180923190.880@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 18 Mar 2004 09:30:16 -0800 (PST)")
Message-ID: <jesmg6avy0.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 18 Mar 2004, David Howells wrote:
>> 
>> The attached patch fixes a minor problem with fcntl.
>
> I agree that it is a cleanup, but I disagree on the "problem" part.
>
>> get_close_on_exec() uses FD_ISSET() to determine the fd state. However,
>> FD_ISSET() does not return 0 or 1 on all archs. On some it returns 0 or non-0,
>> which is fine by POSIX.
>
> FD_ISSET() is broken if it returns anything but 0/1, in my not-so-humble 
> opinion.

POSIX clearly says that _any_ non-zero value is ok, similar to the ctype.h
functions.  Of course, the kernel can set different standards internally.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
