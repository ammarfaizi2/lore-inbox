Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311009AbSCMTGS>; Wed, 13 Mar 2002 14:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311006AbSCMTGI>; Wed, 13 Mar 2002 14:06:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44293 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310995AbSCMTFz>; Wed, 13 Mar 2002 14:05:55 -0500
Subject: Re: [patch] vmalloc_to_page() backport for 2.4
To: tigran@veritas.com (Tigran Aivazian)
Date: Wed, 13 Mar 2002 19:20:58 +0000 (GMT)
Cc: kraxel@bytesex.org (Gerd Knorr),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (Kernel List)
In-Reply-To: <Pine.LNX.4.33.0203131848460.1251-100000@einstein.homenet> from "Tigran Aivazian" at Mar 13, 2002 06:50:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lEJ0-0007Bl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 13 Mar 2002, Gerd Knorr wrote:
> > +EXPORT_SYMBOL_GPL(vmalloc_to_page);
> 
> Can you (or whoever made it EXPORT_SYMBOL_GPL in 2.5) please explain what
> is so "GPL" about exporting this symbol, please? I can understand when
> symbols related to the internals of some subsystem are GPL-only-exported
> but this does not appear to be such a case.

Its an internal helper function shared by some GPL drivers, its not something
you need to register a non free driver. As such its simply in the kernel
core rather than duplicated for the convenience of free driver authors.

Alan
