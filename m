Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271738AbTHHSG0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271739AbTHHSGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:06:25 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:61202 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S271738AbTHHSGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:06:24 -0400
Date: Fri, 8 Aug 2003 20:01:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 bug: kconfig implementation doesn't match the spec
In-Reply-To: <20030808174736.GA16091@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0308081956250.24676-100000@serv>
References: <20030808145107.GY16091@fs.tum.de> <Pine.LNX.4.44.0308081714160.714-100000@serv>
 <20030808174736.GA16091@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 8 Aug 2003, Adrian Bunk wrote:

> > You probably forgot to set MODULES, tristate behaves like bool in this 
> > case and FOO becomes 'y' and '!FOO' is 'n'.
> 
> No, this is with CONFIG_MODULES=y.

How did you set it? I tried your examples and got the expected and correct 
result.

> According to your language definition,
>   m && !m
> evaluates to "m" (it sounds a bit strange but follows directly from
> rules (5) and (7) together with the interpretation of "m" as 1 as 
> explained in the section "Menu dependencies" of
> Documentation/kbuild/kconfig-language.txt).

BTW the reason for (5) !<expr> -> 2-<expr> is that it becomes possible to 
do various transformations with the expressions, e.g. !!<expr> == <expr>.

bye, Roman

