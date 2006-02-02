Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWBBNeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWBBNeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 08:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWBBNeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 08:34:05 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:17042 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751056AbWBBNeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 08:34:04 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Thu, 2 Feb 2006 13:53:30 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602020931.29796.rjw@sisk.pl> <20060202093859.GA1884@elf.ucw.cz>
In-Reply-To: <20060202093859.GA1884@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602021353.30802.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 02 February 2006 10:38, Pavel Machek wrote:
> > Its limitation , however, is that it requires a lot of memory for the system
> > memory snapshot which may be impractical for systems with limited RAM,
> > and that's where your solution may be required.
> 
> Actually, suspend2 has similar limitation. It still needs half a
> memory free, but it does not count caches into that as it can save
> them separately.

I didn't know that.  [If that is the case, I wonder what Nigel means by
the "whole memory image".  Nigel?]

> That means that on certain small systems (32MB RAM?), suspend2 is going to
> have big advantage of responsivity after resume. But on the systems
> where [u]swsusp can't suspend (6MB RAM?), suspend2 is not going to be
> able to suspend, either. [Roughly; due to bugs and implementation
> differences there may be some system size where one works and second
> one does not, but they are pretty similar]

Generally speaking, my perception is that suspend2 may be preferrable below
256 MB of RAM.  Moreover there are some people who seem to prefer
entirely kernel-based suspend, and I'm not going to develop the code
in swap.c and disk.c any further (of course with the exception of bugfixes
etc.).  Nigel has done it already so perhaps there is a room for his code,
too, _provided_ _that_ it is accepted.

Greetings,
Rafael
