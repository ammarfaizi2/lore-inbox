Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264673AbUEOBJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264673AbUEOBJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 21:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUEOBF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 21:05:57 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32738 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264660AbUEOBC4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 21:02:56 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Date: Sat, 15 May 2004 03:05:06 +0200
User-Agent: KMail/1.5.3
Cc: rene.herman@keyaccess.nl, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       arjanv@redhat.com
References: <409F4944.4090501@keyaccess.nl> <20040514032657.GB704@elf.ucw.cz> <20040514175918.6b9f4c9d.akpm@osdl.org>
In-Reply-To: <20040514175918.6b9f4c9d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405150305.06385.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 of May 2004 02:59, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> > > > It's a bit grubby, but we could easily add a fourth state to
> > > >  `system_state': split SYSTEM_SHUTDOWN into SYSTEM_REBOOT and
> > > > SYSTEM_HALT. That would be a quite simple change.
> > >
> > > Like this.  I checked all the SYSTEM_FOO users and none of them seem to
> > > care about the shutdown state at present.  Easy.
> >
> > Perhaps this should be parameter to device_shutdown? This is quite
> > ugly.
>
> Rather than a parameter to ->shutdown it would be better to add a new
> ->restart method to devices and IDE can implement one of those.
>
> I don't know if it's worth the effort though.  Is any other driver likely
> to want to discriminate between reboot and shutdown?

it seems only drivers/char/watchdog/alim7101_wdt.c
(currently uses reboot notifier for that)

