Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271814AbTHHSQY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271820AbTHHSQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:16:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16615 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271814AbTHHSQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:16:23 -0400
Date: Fri, 8 Aug 2003 20:16:13 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 bug: kconfig implementation doesn't match the spec
Message-ID: <20030808181612.GC16091@fs.tum.de>
References: <20030808145107.GY16091@fs.tum.de> <Pine.LNX.4.44.0308081714160.714-100000@serv> <20030808174736.GA16091@fs.tum.de> <Pine.LNX.4.44.0308081956250.24676-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308081956250.24676-100000@serv>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 08:01:20PM +0200, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Fri, 8 Aug 2003, Adrian Bunk wrote:
> 
> > > You probably forgot to set MODULES, tristate behaves like bool in this 
> > > case and FOO becomes 'y' and '!FOO' is 'n'.
> > 
> > No, this is with CONFIG_MODULES=y.
> 
> How did you set it? I tried your examples and got the expected and correct 
> result.

ups, sorry, you are right. I switched between two trees and these 
examples were with CONFIG_MODULES=n. With CONFIG_MODULES=y I observe the 
correct results.

> > According to your language definition,
> >   m && !m
> > evaluates to "m" (it sounds a bit strange but follows directly from
> > rules (5) and (7) together with the interpretation of "m" as 1 as 
> > explained in the section "Menu dependencies" of
> > Documentation/kbuild/kconfig-language.txt).
> 
> BTW the reason for (5) !<expr> -> 2-<expr> is that it becomes possible to 
> do various transformations with the expressions, e.g. !!<expr> == <expr>.

OTOH, the expression
  FOO && !FOO
is not always "n" as you might expect.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

