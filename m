Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbVLSJXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbVLSJXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 04:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVLSJXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 04:23:18 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:52640 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932703AbVLSJXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 04:23:17 -0500
Message-ID: <43A67CEB.3040603@aitel.hist.no>
Date: Mon, 19 Dec 2005 10:27:07 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Puneet Vyas <puneetvyas@gmail.com>
CC: Ismail Donmez <ismail@uludag.org.tr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051211180536.GM23349@stusta.de> <Pine.LNX.4.61.0512152356190.13568@yvahk01.tjqt.qr> <200512160112.30179.ismail@uludag.org.tr> <43A239B4.8010309@gmail.com>
In-Reply-To: <43A239B4.8010309@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Puneet Vyas wrote:

> If the learned folks here think that "ndiswrapper" is some user space 
> program that people can live without than at least
> 3 people in my house are doomed. We like to use linux but do not have 
> luxury that Ismail enjoys. At least windows
> does not make such decisions on my behalf. Sigh.

ndiswrapper can be fixed to work in a 4k stack environment,
even if the windows driver in use needs more than 4k.  This
requires some work, because ndiswrapper will then have to
manage its own stack instead of simply using the provided
kernel stack.  It is up to all people who want ndiswrapper to
actually do this work.

Note that this work ought to be done anyway, as windows
drivers really assumes they can use 12k of stack, which they
cannot do even with the current 8k stack.

Another problem you may get with windows drivers, is licencing issues.
If they want to, they can set the licencing terms so that you
can't legally run the drivers on linux.  Currently, it is only a
question of money.  Buy a windows licence, an you can use the
windows driver on linux.  It may or may not stay that way.  Still, getting
what you want on linux will always be only a matter of money, as there
are wifi cards with _linux_ drivers out there.  Just buy the right ones
the next time you renew your pc.

Helge Hafting


