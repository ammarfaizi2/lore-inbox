Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262166AbVBAXE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVBAXE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVBAXE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:04:28 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:36707 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262162AbVBAXEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:04:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Sl4O8cgK4aPQyJozGsBXQWyOz9TY+FJiT3pESMRsBqz7wB2zkr6LioGDuL2DYS4nL35VCWgjb9zFnXte8wNitlN0qTVM+upLHqq+nFSvZx7NVWLqOqYaiPWUZhtkZh02L5dlV00GNZwdf4i3NnzeoDEB2lB9DNgfTSvivuY5S9k=
Message-ID: <58cb370e05020115032fdb8b59@mail.gmail.com>
Date: Wed, 2 Feb 2005 00:03:30 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [ide-dev 3/5] generic Power Management for IDE devices
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050122184124.GL468@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.GSO.4.58.0501220004050.23959@mion.elka.pw.edu.pl>
	 <20050122184124.GL468@openzaurus.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2005 19:41:24 +0100, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
> 
> > Move PM code from ide-cd.c and ide-disk.c to IDE core so:
> > * PM is supported for other ATAPI devices (floppy, tape)
> > * PM is supported even if specific driver is not loaded
> 
> Why do you need to have state-machine? During suspend we are running
> single-threaded, it should be okay to just do the calls directly.
>                                 Pavel

If we are running single-threaded I also see no reason for state-machine.
Ben?

Pavel, I assume that changes contained in the patch are OK with you?

Bartlomiej
