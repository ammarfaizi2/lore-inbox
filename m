Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbVKYWUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbVKYWUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 17:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVKYWUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 17:20:32 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:22248
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751485AbVKYWUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 17:20:31 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Fri, 25 Nov 2005 16:20:12 -0600
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511251545.32343.rob@landley.net> <20051125220934.GA2268@elf.ucw.cz>
In-Reply-To: <20051125220934.GA2268@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511251620.12996.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 November 2005 16:09, Pavel Machek wrote:
> Ouch, I guess I killed my .config :-(. It seems that interrupted
> miniconfig.sh leaves .config in close to empty state...

That's why it insists you rename it in order to run it.

I intend to fix that somewhat in a newer version of the sucker by having the 
script intercept signals and restore .config on the way out, but it can't be 
fully reliable (not against kill -9) because kconfig overwrites .config and 
the script is repeatedly running allnoconfig.  (I can probably bypass the 
makefile and feed it some strange command line argument, but what Kconfig to 
run it on gets us into architecture dependence issues the make file handles 
for us...)

> I'm not sure what I did wrong last time, it worked this time. My
> miniconfig is 6K instead of 46K, good. Still its quite long. Thanks!

You mentioned you set a lot of options. :)

I agree scripts/miniconfig.sh is clumsy.  I'm thinking about improvements 
(both to how it works and to the user interface), but I need to catch up on 
some other stuff first...

>        Pavel

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
