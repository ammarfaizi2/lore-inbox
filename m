Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268253AbTBYTZi>; Tue, 25 Feb 2003 14:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268255AbTBYTZi>; Tue, 25 Feb 2003 14:25:38 -0500
Received: from h-64-105-35-241.SNVACAID.covad.net ([64.105.35.241]:37866 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S268253AbTBYTZb>; Tue, 25 Feb 2003 14:25:31 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 25 Feb 2003 11:26:57 -0800
Message-Id: <200302251926.LAA02142@adam.yggdrasil.com>
To: kai@tp1.ruhr-uni-bochum.de
Subject: Re: Replacement for "make SUBDIRS=...." in 2.5.63?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, Kai Germaschewski wrote;
>On Mon, 24 Feb 2003, Adam J. Richter wrote:

>> 	I see that if I do something like "make SUBDIRS=net/ipv4 modules",
>> I get warnings like:
>> 
>> *** Warning: Overriding SUBDIRS on the command line can cause inconsistencies
>> *** Uh-oh, you have stale module entries. You messed with SUBDIRS

>The first warning only explicitly states a fact which has always been 
>true: If you hide information from kbuild by not letting it descend into 
>all subdirectories (but only the ones you specified on the command line), 
>you do not get a guarantee that everything is properly up-to-date.

[...]

>As I said, the warning only states what was always true. However, the
>reason it was added now is that the module postprocessing step needs a
>list of all modules to get symbol versioning right (and it needs to be
>sure that all those modules are up-to-date w.r.t the current .config etc).

	In the past, one could rebuild symbol versions with the faster
step of "make depend".  It's fine if you want to combine code
generation and generating symbol information in one step when all of
the .o's are being built, but it would be nice to still have the
ability to just update the symbol information.  I'm not necessarily
volunteering to add this (but who knows), but I'd like to know if
there is some reason why this couldn't be added to the current kbuild.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
