Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVBCLRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVBCLRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVBCLOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:14:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:63620 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263012AbVBCLIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:08:11 -0500
Subject: Re: [ide-dev 3/5] generic Power Management for IDE devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e05020115032fdb8b59@mail.gmail.com>
References: <Pine.GSO.4.58.0501220004050.23959@mion.elka.pw.edu.pl>
	 <20050122184124.GL468@openzaurus.ucw.cz>
	 <58cb370e05020115032fdb8b59@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107332644.14782.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 03 Feb 2005 10:03:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-02-01 at 23:03, Bartlomiej Zolnierkiewicz wrote:
> On Sat, 22 Jan 2005 19:41:24 +0100, Pavel Machek <pavel@suse.cz> wrote:
> > Why do you need to have state-machine? During suspend we are running
> > single-threaded, it should be okay to just do the calls directly.
> >                                 Pavel
> 
> If we are running single-threaded I also see no reason for state-machine.
> Ben?

There may be outstanding I/O running at the time of the suspend. You
want to keep everything nicely ordered. The state machine suspend code
looks to me the right answer and is cleaner.

