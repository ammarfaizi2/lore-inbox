Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSFFI7I>; Thu, 6 Jun 2002 04:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315517AbSFFI7H>; Thu, 6 Jun 2002 04:59:07 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:51918 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315491AbSFFI7G>; Thu, 6 Jun 2002 04:59:06 -0400
Date: Thu, 6 Jun 2002 10:59:07 +0200
From: Jan Hudec <bulb@ucw.cz>
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
Message-ID: <20020606085907.GA28704@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <3CFD19D1.5768FCF8@compro.net> <20020605194716.4290.qmail@web14906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 03:47:16PM -0400, Michael Zhu wrote:
> Hi, I've read the man page of modules.conf. But I
> still couldn't figure out how to solve my problem. I
> mean how to change the modules.conf file. Can I edit
> this file directly? Can anyone give me an example?

You say you read the page. ... Hey, wait a moment!
There are TWO files. /etc/modules.conf, that defines how to load modules
when they are requested (default parameters), which modules to load on
kernel request (autoloading) etc. And then there is another file -
/etc/modules, that is simply processed like
for each line do modprobe <the line>
during boot process.


So depending on what kind of module you have. If it's a module for some
device, you can make the alias in modules.conf and kernel will ask for
it when it's needed. It also works for some special cases (like iptables
- they don't even need an alias). For other things, especially network
device drivers you need to load them from /etc/modules

Note: ALL config files on unix are made so that they can be edited by
hand using eny editor.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
