Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVBKIfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVBKIfb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 03:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVBKIfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 03:35:31 -0500
Received: from sd291.sivit.org ([194.146.225.122]:49618 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262222AbVBKIf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 03:35:26 -0500
Date: Fri, 11 Feb 2005 09:37:05 +0100
From: Stelian Pop <stelian@popies.net>
To: dtor_core@ameritech.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] sonypi driver update
Message-ID: <20050211083705.GA3263@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	dtor_core@ameritech.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20050210154420.GE3493@crusoe.alcove-fr> <d120d500050210112417751633@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d500050210112417751633@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 02:24:58PM -0500, Dmitry Torokhov wrote:

> On Thu, 10 Feb 2005 16:44:21 +0100, Stelian Pop <stelian@popies.net> wrote:
> > Hi,
> > 
> > Over the last few weeks I've collected a few patches in my tree
> > coming from others and it's time to merge them upstream:
> > 
> >        1/5: sonypi: replace schedule_timeout() with msleep()
> >        2/5: sonypi: add another HELP button event
> >        3/5: sonypi: use MISC_DYNAMIC_MINOR in miscdevice.minor assignment.
> >        4/5: sonypi: fold the contents of sonypi.h into sonypi.c
> >        5/5: sonypi: add fan and temperature status/control
> 
> Any chance that last one could be done via sysfs attributes instead of
> new IOCTLs? This way you can control fan from the command line.

Good suggestion, but I'd rather not mix ioctls and sysfs attrs. In
some future version (development branch ? ahem) I'll switch to sysfs
for all the controls and implement backward compatibility in the
userspace tool.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
