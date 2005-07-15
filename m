Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVGORlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVGORlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbVGORlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:41:49 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:21778 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261624AbVGORls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:41:48 -0400
Date: Fri, 15 Jul 2005 14:41:29 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Egry =?iso-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>,
       Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>
Subject: Re: [PATCH 0/19] Kconfig I18N completion
Message-ID: <20050715174129.GB26338@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	Egry =?iso-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>,
	Sam Ravnborg <sam@ravnborg.org>,
	Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
	Massimo Maiurana <maiurana@inwind.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	KernelFR <kernelfr@traduc.org>
References: <1121273456.2975.3.camel@spirit> <Pine.LNX.4.58.0507131038560.17536@g5.osdl.org> <1121277818.2975.68.camel@spirit> <20050713201147.GA23746@mars.ravnborg.org> <1121280104.2975.84.camel@spirit> <Pine.LNX.4.58.0507131155460.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507131155460.17536@g5.osdl.org>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.9i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 13, 2005 at 12:02:20PM -0700, Linus Torvalds escreveu:
> 
> 
> On Wed, 13 Jul 2005, Egry Gábor wrote:
> > 
> > Yes, the patch 19/19 contains the translation of configuration
> > interfaces ([x|g|menu]config) and it is only 23 kb. The full version of
> > unfinished hu.po is 2 MB and the fully translated italian it.po is 3,2
> > MB. I see Linus doesn't want the huge language files in kernel source.
> > But what is Linus opinion about this little .po file?
> 
> I don't want ANY of it in the kernel. 

Neither me.
 
> Quite frankly, I'm of the opinion that _all_ of the i18n stuff should be 
> totally outside the kernel. I took the patch from Arnaldo only because I 
> was told that me taking that patch would allow external packages to do the 
> rest. Now I'm told that isn't true, which just makes me pissed off.
> 
> _I_ think you should have a totally external package that knows how to
> parse the Kconfig files. They have a well-known format that hasn't changed
> in quite a while, and a nice parser.  Yes, there will inevitably be new
> entries that you don't have translations for, and you'll have to use the
> English ones for those, but the fact is, that is true whether the i18n
> stuff is included with the kernel or not.

Having just kxgettext as I submitted I guess is enough, the translators
just do make update-po-config and do the translations, put that somewhere
for anyone who wants to use it.
 
> And exactly _because_ it doesn't help to put the non-English translations 
> into the kernel, I think it's a mistake to even try. It's likely _easier_ 
> for all the different language groups if they can just work on their _own_ 
> project, and don't have to try to get their translations merged into the 
> standard kernel.

Exactly.

- Arnaldo
