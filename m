Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbUKUW3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbUKUW3s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 17:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUKUW3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 17:29:48 -0500
Received: from [213.85.13.118] ([213.85.13.118]:1669 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261823AbUKUW3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 17:29:30 -0500
To: linux-os@analogic.com
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
References: <20041120143755.E13550@flint.arm.linux.org.uk>
	<Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com>
From: Nikita Danilov <nikita@clusterfs.com>
Date: Mon, 22 Nov 2004 01:29:08 +0300
In-Reply-To: <Pine.LNX.4.61.0411211705480.16359@chaos.analogic.com> (linux-os@chaos.analogic.com's
 message of "Sun, 21 Nov 2004 17:10:59 -0500 (EST)")
Message-ID: <m1brdqn8ej.fsf@clusterfs.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.5 (chayote, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@chaos.analogic.com> writes:

> On Sat, 20 Nov 2004, Russell King wrote:
>

[...]

>>
>> int tickadj = 500/HZ ? : 1;             /* microsecs */
>>
>> which makes it look like sparse doesn't understand such constructions.
>
> I don't think any 'C' compiler should understand such constructions
> either.
>  	There is no result for the TRUE condition, and the standard
> does not provide for a default. The compiler should have written
> a diagnostic.

This is GCC extension.

    foo ? : bar

is equivalent to

    foo ? foo : bar

except that foo is evaluated only once.

Nikita.
