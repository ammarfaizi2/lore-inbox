Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261803AbREPG5c>; Wed, 16 May 2001 02:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbREPG5W>; Wed, 16 May 2001 02:57:22 -0400
Received: from geos.coastside.net ([207.213.212.4]:56776 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261803AbREPG5F>; Wed, 16 May 2001 02:57:05 -0400
Mime-Version: 1.0
Message-Id: <p0510033db727cdc4a244@[207.213.214.37]>
In-Reply-To: <3B01E670.E96A2865@uow.edu.au>
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>,	
 <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
 <p05100330b7277e2beea6@[207.213.214.37]> <3B01E670.E96A2865@uow.edu.au>
Date: Tue, 15 May 2001 23:56:41 -0700
To: Andrew Morton <andrewm@uow.edu.au>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:31 PM +1000 2001-05-16, Andrew Morton wrote:
>  > When I ifconfig one of a collection of interfaces, I'm very much
>>  talking about the specific physical interface connected via a
>  > specific physical cable to a specific physical switch port.
>>
>
>Yes, it can be a security trap as well - physically move a card and
>your firewall rules end up being applied to the wrong connection.
>
>The 2.4 kernel allows you to rename an interface.  So you can build
>a little database of (MAC address/name) pairs. Apply this after booting
>and before bringing up the interfaces and everything has the name
>you wanted, based on MAC address.
>
>Andi Kleen has an app which does this:
>
>	ftp://ftp.firstfloor.org/pub/ak/smallsrc/nameif.c
>
>but apparently some additional kernel work is needed to make
>this work 100% correctly.  I do not know what the specific
>problem is.

There's a bit of a catch 22, though, if you don't have unique MAC 
addresses in the system (across multiple interfaces). It's common 
practice in the SPARC world (Solaris, anyway) for all the interfaces 
to default to a single system-wide MAC address. The fact that MAC 
addresses are at least semi-volatile is also bothersome.

It's also  true that some buses simply don't yield up physical 
locations (ISA springs to mind, and I gather that FC is squishy that 
way), but it's desirable to be able to make the connection all ways 
(eth# <-> bus location <-> physical location <-> MAC address) in a 
uniform manner. (Where MAC address might be something else in a 
non-Ethernet domain.)
-- 
/Jonathan Lundell.
