Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbSKCUrv>; Sun, 3 Nov 2002 15:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSKCUru>; Sun, 3 Nov 2002 15:47:50 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:46341 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262394AbSKCUrs>; Sun, 3 Nov 2002 15:47:48 -0500
Date: Sun, 3 Nov 2002 21:54:05 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Russell King <rmk@arm.linux.org.uk>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5: troubles with piping make output
In-Reply-To: <20021103202446.F5589@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211032146240.6949-100000@serv>
References: <200211031122.gA3BMbp27805@Port.imtp.ilyichevsk.odessa.ua>
 <20021103182805.GA1057@mars.ravnborg.org> <200211031946.gA3JkIp29186@Port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.44.0211032106010.6949-100000@serv> <20021103202446.F5589@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Nov 2002, Russell King wrote:

> No thanks.  That breaks my build scripts.  I don't want to go logging into
> multiple machines just to run make oldconfig when the old system worked
> perfectly well.
> 
> "perfectly well" here means that make oldconfig worked over ssh, with the
> local end logging the stdout to a file as well as the terminal, with stdin
> from the terminal.  It is quite reasonable to expect the configuration to
> continue as normal.

Huh? What do you mean? oldconfig still works as before, above only happens 
if you touch .config or a Kconfig file, kconfig tries to automatically 
update .config and will fail if stdio is redirected, but needs user input.
The problem is not a missing fflush, the question is why kconfig couldn't 
detect the pipe.

bye, Roman

