Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269238AbUINJna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269238AbUINJna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269090AbUINJna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:43:30 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:49795 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S269242AbUINJkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:40:52 -0400
Date: Tue, 14 Sep 2004 11:40:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       reiser@namesys.com, wli@holomorphy.com, zam@namesys.com
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined   
 atomic_sub_and_test
In-Reply-To: <OF6D4E73AE.1DB1AD2F-ON42256F0F.003132FF-42256F0F.00321365@de.ibm.com>
Message-ID: <Pine.LNX.4.61.0409141128590.877@scrub.home>
References: <OF6D4E73AE.1DB1AD2F-ON42256F0F.003132FF-42256F0F.00321365@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 14 Sep 2004, Martin Schwidefsky wrote:

> > On some archs atomic_sub_return is more complex than atomic_sub_and_test
> > and there it does make a difference.
> 
> Well even if you can save lets say 10 cycles for the atomic_sub_return
> primitive you still won't notice any difference. The code in question
> is part of the end i/o function.

It's not just about this particular piece of code, if we introduce this as 
official API, people will start using it and in some cases it might 
matter. atomic_dec_and_test() can also be implemented using 
atomic_sub_return(), but I doubt you want to replace or deprecate it.

bye, Roman
