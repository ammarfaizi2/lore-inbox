Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWC3MZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWC3MZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWC3MZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:25:58 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:50386 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932193AbWC3MZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:25:57 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Date: Thu, 30 Mar 2006 14:24:50 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Mark Lord <lkml@rtr.ca>,
       linux-kernel@vger.kernel.org
References: <200603281601.22521.ncunningham@cyclades.com> <20060330120514.GO8485@elf.ucw.cz> <200603301417.18646.rjw@sisk.pl>
In-Reply-To: <200603301417.18646.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603301424.50562.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 14:17, Rafael J. Wysocki wrote:
> On Thursday 30 March 2006 14:05, Pavel Machek wrote:
> > > > I do not see missing includes, so I'm not sure it will help. Can you
> > > > try adding
> > > >
> > > > ARCH=x86_64
> > > >
> > > > to Makefile?
> > > 
> > > Heh. It worked. Maybe you should have something to figure out what arch the 
> > > user is using :) It seems a bit strange to tell the compiler that I'm using 
> > > the arch it ought to know I'm using.
> > 
> > Good. Does 
> > 
> > ARCH=`uname -m`
> > 
> > work, too?
> 
> No, it doesn't.

Something like this works, though:

ARCH:=$(shell uname -m)

Rafael
