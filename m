Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbVGMTFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbVGMTFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVGMTD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:03:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57273 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262417AbVGMTC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:02:56 -0400
Date: Wed, 13 Jul 2005 12:02:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?Egry_G=E1bor?= <gaboregry@t-online.hu>
cc: Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH 0/19] Kconfig I18N completion
In-Reply-To: <1121280104.2975.84.camel@spirit>
Message-ID: <Pine.LNX.4.58.0507131155460.17536@g5.osdl.org>
References: <1121273456.2975.3.camel@spirit>  <Pine.LNX.4.58.0507131038560.17536@g5.osdl.org>
  <1121277818.2975.68.camel@spirit>  <20050713201147.GA23746@mars.ravnborg.org>
 <1121280104.2975.84.camel@spirit>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Jul 2005, Egry Gábor wrote:
> 
> Yes, the patch 19/19 contains the translation of configuration
> interfaces ([x|g|menu]config) and it is only 23 kb. The full version of
> unfinished hu.po is 2 MB and the fully translated italian it.po is 3,2
> MB. I see Linus doesn't want the huge language files in kernel source.
> But what is Linus opinion about this little .po file?

I don't want ANY of it in the kernel. 

Quite frankly, I'm of the opinion that _all_ of the i18n stuff should be 
totally outside the kernel. I took the patch from Arnaldo only because I 
was told that me taking that patch would allow external packages to do the 
rest. Now I'm told that isn't true, which just makes me pissed off.

_I_ think you should have a totally external package that knows how to
parse the Kconfig files. They have a well-known format that hasn't changed
in quite a while, and a nice parser.  Yes, there will inevitably be new
entries that you don't have translations for, and you'll have to use the
English ones for those, but the fact is, that is true whether the i18n
stuff is included with the kernel or not.

And exactly _because_ it doesn't help to put the non-English translations 
into the kernel, I think it's a mistake to even try. It's likely _easier_ 
for all the different language groups if they can just work on their _own_ 
project, and don't have to try to get their translations merged into the 
standard kernel.

			Linus
