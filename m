Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVFMBRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVFMBRB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 21:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVFMBRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 21:17:01 -0400
Received: from innocence-lost.us ([66.93.152.112]:63404 "EHLO
	innocence-lost.net") by vger.kernel.org with ESMTP id S261307AbVFMBQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 21:16:57 -0400
Date: Sun, 12 Jun 2005 18:16:43 -0700 (MST)
From: jnf <jnf@innocence-lost.net>
To: Linus Torvalds <torvalds@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       drepper@redhat.com
Subject: Re: Add pselect, ppoll system calls.
In-Reply-To: <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>
References: <1118444314.4823.81.camel@localhost.localdomain>
 <1118616499.9949.103.camel@localhost.localdomain>
 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>
X-GPG-PUBLIC_KEY: http://innocence-lost.net/jnf-pubkey.asc
X-GPG-FINGRPRINT: E24B 994F D483 12EF 61D4  A384 1F16 EFD1 E1A7 954C
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I realize this is off subject to the mailing list, however its not really
off subject to the thread. What is the suggested method for dealing with
this? i.e. catching sigint which sets a global variable and then having
select() inside the loop, i.e.

while (boolean < 1 ) {
   [...]
   select(...);
   [...]
}

regards,

jnf


On Sun, 12 Jun 2005, Linus Torvalds wrote:

> Date: Sun, 12 Jun 2005 17:26:43 -0700 (PDT)
> From: Linus Torvalds <torvalds@osdl.org>
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: David Woodhouse <dwmw2@infradead.org>,
>     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
>     drepper@redhat.com
> Subject: Re: Add pselect, ppoll system calls.
>
>
>
> On Sun, 12 Jun 2005, Alan Cox wrote:
> >
> > If glibc has a race why not just fix glibc ?
>
> .. because glibc tries to implement the "pselect()" interfaces that some
> other OS's implement.
>
> Whether that is a good idea or not (it's not) is a different issue, but
> basically it means that apps don't use the longjmp trick exactly because
> they think pselect() works ok.
>
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
