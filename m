Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVFUROZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVFUROZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVFURNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:13:21 -0400
Received: from mail.linicks.net ([217.204.244.146]:8200 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S262176AbVFURGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:06:10 -0400
From: Nick Warne <nick@linicks.net>
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Date: Tue, 21 Jun 2005 18:06:07 +0100
User-Agent: KMail/1.8.1
References: <200506191639.27970.nick@linicks.net> <20050621064554.GC15239@kroah.com>
In-Reply-To: <20050621064554.GC15239@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506211806.07411.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 07:45, you wrote:

> > It turns out to be a problem (typo?) in  /etc/udev/rules.d/udev.rules
> >
> > Try changing:
> >
> > # pty devices
> > KERNEL="pty[p-za-e][0-9a-f]*", NAME="pty/m%n", SYMLINK="%k"
> > KERNEL="tty[p-za-e][0-9a-f]*", NAME="tty/s%n", SYMLINK="%k"
> >
> > to:
> >
> > # pty devices
> > KERNEL="pty[p-za-e][0-9a-f]*", NAME="pty/m%n", SYMLINK="%k"
> > KERNEL="tty[p-za-e][0-9a-f]*", NAME="pty/s%n", SYMLINK="%k"
> >
> > (change is in second line tty -> pty)
>
> Hm, that's what already ships with the udev tarball in the gentoo rule
> set (which is usually the most up-to-date rule set in the tarball.)
>
> Which one are you looking at?

This wasn't my 'solution' - I googled:

http://kerneltrap.org/node/4474

I don't understand why 'less' broke at all...

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
