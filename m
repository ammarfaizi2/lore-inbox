Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311607AbSCNM1N>; Thu, 14 Mar 2002 07:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311605AbSCNM1E>; Thu, 14 Mar 2002 07:27:04 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:53034 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S311602AbSCNM0u>;
	Thu, 14 Mar 2002 07:26:50 -0500
Date: Thu, 14 Mar 2002 12:30:14 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Gerd Knorr <kraxel@bytesex.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel List <linux-kernel@vger.kernel.org>, <arjan@fenrus.demon.nl>
Subject: Re: [patch] vmalloc_to_page() backport for 2.4
In-Reply-To: <E16lEJ0-0007Bl-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203141219180.1643-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Alan,

On Wed, 13 Mar 2002, Alan Cox wrote:

> > On Wed, 13 Mar 2002, Gerd Knorr wrote:
> > > +EXPORT_SYMBOL_GPL(vmalloc_to_page);
> >
> > Can you (or whoever made it EXPORT_SYMBOL_GPL in 2.5) please explain what
> > is so "GPL" about exporting this symbol, please? I can understand when
> > symbols related to the internals of some subsystem are GPL-only-exported
> > but this does not appear to be such a case.
>
> Its an internal helper function shared by some GPL drivers, its not something
> you need to register a non free driver. As such its simply in the kernel
> core rather than duplicated for the convenience of free driver authors.

Thank you for answering my query, but one may disagree that it is an
internal helper function because it can conceivably be used by modules to
help them be independent of PAE/non-PAE kernel configuration. And, as
such, it suggests that the _GPL bit in the export clause is not justified
and should be removed. There is no reason whatsoever why Linux base kernel
should allow some useful functionality to GPL modules and disallow the
same to non-GPL ones.

In other words, your statement is absolutely correct when applied to other
EXPORT_SYMBOL_GPL symbols but, imho, is incorrect when applied to this
particular one.

I cc'd Arjan because, perhaps, he has some other technical reasons why it
is _GPL'd, in which case my query would be covered completely. (Obviously,
being unfriendly to non-GPL modules is not a valid technical reason :)

(note, that despite me writing this email as @veritas.com we don't
actually need this symbol to be _GPL but if I believe something is not
right I feel it is my duty to say so -- maybe it helps someone else in the
future, if not directly ourselves now)

Regards,
Tigran


