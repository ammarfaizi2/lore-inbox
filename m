Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSDCUJp>; Wed, 3 Apr 2002 15:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311264AbSDCUJg>; Wed, 3 Apr 2002 15:09:36 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:38200 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S311025AbSDCUJ0>;
	Wed, 3 Apr 2002 15:09:26 -0500
Date: Wed, 3 Apr 2002 21:05:58 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
        Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <E16sqAf-0004JH-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204032051530.1163-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Alan Cox wrote:
> Taking code I am one of the authors of and making it convenient for
> people like veritas to use in non GPL code is quite different. Its
> theft plain and simple.

Alan,

I don't want to try your patience but I have to emphasize that:

yes, it should be authors decision (completely agree with you there!)
whether a symbol is exported or not and whether it should be exported to
all modules or only to some "internal/kernel" modules. But this is a
technical issue, nothing to do with legalities/licenses or author's likes
or dislikes of binary modules.

But if the author's decision is based on a statement similar to "I spent N
hours writing this function, it's okay to let GPL modules use it but no
way I'll let the nasty veritas-like people use it", then I feel something
is wrong somewhere. Then perhaps we could even refine the API to have

EXPORT_SYMBOL_FRIENDS(sym,list_of_friends)

where only "friends" can use the symbol and even then only if they first
call (an exported function):

register_export_payment(sym, sum);

where 'sum' depends on the number of hours spent on writing sym().

I feared that perhaps I misunderstood the meaning of EXPORT_SYMBOL_GPL but
in the other "instance" of this thread Linus did confirm that it was
correct.

Regards,
Tigran


PS. unimportant detail for curious listeners on linux-kernel -- Veritas
doesn't actually need vmalloc_to_page exported in any manner or form.

