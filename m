Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312395AbSDCUaJ>; Wed, 3 Apr 2002 15:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSDCU37>; Wed, 3 Apr 2002 15:29:59 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:37951 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S312392AbSDCU3o>;
	Wed, 3 Apr 2002 15:29:44 -0500
Date: Wed, 3 Apr 2002 21:27:52 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
        Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.33.0204032051530.1163-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.33.0204032123470.1163-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Tigran Aivazian wrote:
> is wrong somewhere. Then perhaps we could even refine the API to have
>
> EXPORT_SYMBOL_FRIENDS(sym,list_of_friends)
>
> where only "friends" can use the symbol and even then only if they first
> call (an exported function):
>
> register_export_payment(sym, sum);
>
> where 'sum' depends on the number of hours spent on writing sym().

I hope it is obvious it was a joke? Perhaps to make the joke intention
clearer I should have suggested a better "symbol exporting protocol" from
kindergarten experience:

module -> kernel: export your symbols, please
kernel -> module: you export yours first and I'll export some of mine

which is not totally unlike the scheme suggested by bona fide
EXPORT_SYMBOL_GPL defenders, namely "if binary-only modules don't
contribute to the base kernel why should the base kernel let them use it's
symbols".

Regards,
Tigran

