Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292257AbSBBIkq>; Sat, 2 Feb 2002 03:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292259AbSBBIkh>; Sat, 2 Feb 2002 03:40:37 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:4341 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S292257AbSBBIk3>; Sat, 2 Feb 2002 03:40:29 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <25095.1012637318@ocs3.intra.ocs.com.au> 
In-Reply-To: <25095.1012637318@ocs3.intra.ocs.com.au> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 02 Feb 2002 08:40:11 +0000
Message-ID: <23050.1012639211@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  There is also a problem with exported symbols.  To ld, EXPORT_SYMBOL
> looks like a reference to the symbol, 

Er, surely that's not a problem at all? This is desired behaviour?

>  but the export entry is irrelevant,  what really matters is if any module
> refers to those symbols.

Absolutely not.  If we mark a symbol EXPORT_SYMBOL, we want it exported. No 
questions asked.

The export entry _is_ relevant; furthermore it's the _only_ thing that's
relevant, and there is no way of knowing if there's a module that isn't in
the tree, or maybe even a module that _is_ in the tree but not compiled
today, that needs the symbol in question.

I sincerely hope it's just too early in the morning here and I'm 
misunderstanding you :)

--
dwmw2


