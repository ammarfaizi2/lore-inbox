Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbWKOOLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWKOOLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 09:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWKOOLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 09:11:10 -0500
Received: from raven.upol.cz ([158.194.120.4]:27067 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1030467AbWKOOLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 09:11:09 -0500
Date: Wed, 15 Nov 2006 14:17:35 +0000
To: Valdis.Kletnieks@vt.edu, Jan Beulich <jbeulich@novell.com>,
       draconx@gmail.com, jpdenheijer@gmail.com, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: kbuild-mm: $(objtree)/knull vs mktemp (was Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch)
Message-ID: <20061115141735.GA18137@flower.upol.cz>
References: <200610290816.55886.ak@suse.de> <slrnek9qv0.2vm.olecom@flower.upol.cz> <20061029225234.GA31648@uranus.ravnborg.org> <4545C2D8.76E4.0078.0@novell.com> <slrnekbv60.2vm.olecom@flower.upol.cz> <slrnekc3q8.2vm.olecom@flower.upol.cz> <200610301522.k9UFMXmM004701@turing-police.cc.vt.edu> <slrnekc8np.2vm.olecom@flower.upol.cz> <slrnekcu6m.2vm.olecom@flower.upol.cz> <20061031002757.GF2933@quickstop.soohrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061031002757.GF2933@quickstop.soohrt.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 01:27:57AM +0100, Horst Schirmeier wrote:
> # Immortal knull for mortals and roots
> define knull
>   $(shell \
>     if test ! -L knull; \
>       then rm -f knull; ln -s /dev/null knull; \
>     fi; \
>     echo knull)
> endef

So, i think this is much better than mktemp and friends.
Current -mm have +4 temp files after every make help, make, make something.

I'm steel looking forward for comments from (busy) developers, like Sam.

Now i have my laptop back and i can finish this up. Hm?
____
