Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSG2JyZ>; Mon, 29 Jul 2002 05:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSG2JyZ>; Mon, 29 Jul 2002 05:54:25 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:47366 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S314278AbSG2JyY>; Mon, 29 Jul 2002 05:54:24 -0400
Date: Mon, 29 Jul 2002 10:39:12 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, torvalds@transmeta.com
Subject: Re: [PATCH] automatic initcalls
Message-ID: <20020729103912.A18765@nightmaster.csn.tu-chemnitz.de>
References: <20020728033359.7B2A2444C@lists.samba.org> <3D436A44.8080505@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3D436A44.8080505@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Jul 27, 2002 at 11:51:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 11:51:32PM -0400, Jeff Garzik wrote:
> I've always preferred a system where one simply lists dependencies [as 
> you describe above], and some program actually does the hard work of 
> chasing down all the initcall dependency checking and ordering.

So we just need to build a directed graph, detect edges without
existing nodes (someone changed the initcall, we depend on) and
cycles (someone messed up the ordering) as errors, sort the
resulting graph toplogically and dump it as a sequence.

This is no rocket science and we have two tools, which does this
all for us (make and tsort, which create a warning for both cases).

The hard part is to CREATE all the dependencies and check and
double check them with the maintainers.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
