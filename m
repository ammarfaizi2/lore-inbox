Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135965AbREBVEl>; Wed, 2 May 2001 17:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135940AbREBVEb>; Wed, 2 May 2001 17:04:31 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:44550 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135908AbREBVEQ>; Wed, 2 May 2001 17:04:16 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200105022051.WAA27165@kufel.dom>
Subject: Re: xconfig is broken (example ppc 8xx)
To: kufel!mvista.com!george@green.mif.pg.gda.pl (george anzinger)
Date: Wed, 2 May 2001 22:51:24 +0200 (CEST)
Cc: kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl (linux-kernel@vger.kernel.org)
In-Reply-To: <3AF031DC.B8D793FE@mvista.com> from "george anzinger" at maj 02, 2001 09:12:12 
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To show the problem do:
> 
> make xconfig ARCH=ppc
> 
> in the "Platform support" menu "Processor Type" select "8xx" then close
> the subminue with "MainMenu"
> 
> now select "Save and Exit"
> 
> This produces the following error messages:
> 
> ERROR - Attempting to write value for unconfigured variable
> (CONFIG_SCC_ENET).
> ERROR - Attempting to write value for unconfigured variable
> (CONFIG_FEC_ENET).

> I think the problem is that the "wish" script builder does not allow a
> CONFIG option to be configured in two different places, even if only one

Exactly.

> of scripts should be included.

xconfig is not an on-line parser as other interpreters.
It is a script build as effect of parsing of the whole config tree
and includes all possible options.

The problem is that xconfig is based on an assumption that an
unconfigured/disabled option variable preserves its value (as "hidden")
for future reuse. It is in generel contradiction with reusing same
option in more than ane place in the config tree.

And nobody wants to rewrite xconfig (removing the mentioned above
assumption) at the end (hopefully in 2.5) of its life ...

Andrzej
