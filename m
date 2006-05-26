Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWEZKdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWEZKdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWEZKdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:33:06 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:58322 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751378AbWEZKdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:33:04 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp in 2.6.16: works fine w/o PSE...
Date: Fri, 26 May 2006 12:33:23 +0200
User-Agent: KMail/1.9.1
Cc: kronos@kronoz.cjb.net, Michael Tokarev <mjt@tls.msk.ru>,
       linux-kernel@vger.kernel.org
References: <20060524230538.GA616@dreamland.darkstar.lan> <20060525214350.GC6347@elf.ucw.cz>
In-Reply-To: <20060525214350.GC6347@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261233.24186.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 25 May 2006 23:43, Pavel Machek wrote:
> > I'm CC-ing the two swsusp gurus ;)
> > 
> > > I was just feeling lucky and tried suspend-to-disk cycle
> > > on my VIA C3 machine, which lacks PSE which is marked as
> > > being required for swsusp to work.  After commenting out
> > > the PSE check in include/asm-i386/suspend.h and rebooting,
> > > I tried the whole cycle, several times, with real load
> > > (while running 3 kernel compile in parallel) and while
> > > IDLE... And surprizingly, it all worked flawlessly for
> > > me, without a single glitch...
> > > 
> > > So the question is: is PSE really needed nowadays?
> 
> I think so. Or can you prove that pagetables are not going to be
> overwritten in wrong order in !PSE case?
> 
> Look at x86-64 how !PSE case can be solved, but it is a bit of code.

Well, on i386 it'll have to be more complicated, because on x86_64 we use
2 MB pages for the temporary 1-1 mapping.

Greetings,
Rafael
