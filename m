Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQKAKtZ>; Wed, 1 Nov 2000 05:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129991AbQKAKtF>; Wed, 1 Nov 2000 05:49:05 -0500
Received: from [62.172.234.2] ([62.172.234.2]:52115 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129908AbQKAKsy>;
	Wed, 1 Nov 2000 05:48:54 -0500
Date: Wed, 1 Nov 2000 10:49:07 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Peter Hawkins <peter@hawkins.emu.id.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: ISSUE: infinite fork() kills 2.4.0-test10
In-Reply-To: <20001101213952.A550@blackhole>
Message-ID: <Pine.LNX.4.21.0011011045430.1722-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Peter Hawkins wrote:

> Hi...
> 
> I am not subscribed to this list at present (subscription is pending approval), so please CC me with replies.
> 
> This simple program run as an unprivileged user effectively kills 2.4.0-test10 "Greased weasel":
> int main(void)
> {
> fork();
> main();
> return 0;
> }
> 
> Watching a top(1) listing once this program has been started, the load average briefly hits ~560, before the system temporarily ceases responding. After a few seconds, all processes on consoles are killed, and there is an endless spew of:
> __alloc_pages: 1-order allocation failed

and what part of the above do you consider to be a bug? So you have a
misconfigured system with no limits setup for a user (nobody _should_ need
them, users must be educated and not run the above stupid programs) and
expect the system to somewhow "guess" the kind of behaviour you expect?
How can it possibly guess? To me, the above is quite expected behaviour
for a desktop configuration.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
