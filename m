Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSFFJQg>; Thu, 6 Jun 2002 05:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316915AbSFFJQf>; Thu, 6 Jun 2002 05:16:35 -0400
Received: from smtp-server6.tampabay.rr.com ([65.32.1.43]:46218 "EHLO
	smtp-server6.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S316898AbSFFJQd>; Thu, 6 Jun 2002 05:16:33 -0400
Message-ID: <3CFF2880.8D697F90@cfl.rr.com>
Date: Thu, 06 Jun 2002 05:16:48 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
CC: Jan Hudec <bulb@ucw.cz>
Subject: Re: Load kernel module automatically
In-Reply-To: <3CFD19D1.5768FCF8@compro.net> <20020605194716.4290.qmail@web14906.mail.yahoo.com> <20020606085907.GA28704@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec wrote:
> 
> On Wed, Jun 05, 2002 at 03:47:16PM -0400, Michael Zhu wrote:
> > Hi, I've read the man page of modules.conf. But I
> > still couldn't figure out how to solve my problem. I
> > mean how to change the modules.conf file. Can I edit
> > this file directly? Can anyone give me an example?
> 
> You say you read the page. ... Hey, wait a moment!
> There are TWO files. /etc/modules.conf, that defines how to load modules
> when they are requested (default parameters), which modules to load on
> kernel request (autoloading) etc. And then there is another file -
> /etc/modules, that is simply processed like
> for each line do modprobe <the line>
> during boot process.
> 
> So depending on what kind of module you have. If it's a module for some
> device, you can make the alias in modules.conf and kernel will ask for
> it when it's needed. It also works for some special cases (like iptables
> - they don't even need an alias). For other things, especially network
> device drivers you need to load them from /etc/modules
> 
That isn't the case.  There is no /etc/modules file on any Linux box I've
ever used. My network driver modules are loaded automatically by the kernel's
internal module loader "kmod" because the are set up correctly in /etc/modules.conf.

"alias eth0 3c905"

ALL device driver modules can be set up to load automatacally by "kmod".

Mark
