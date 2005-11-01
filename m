Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbVKAX4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbVKAX4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKAXzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:55:55 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:57792 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751459AbVKAXzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:55:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/3] swsusp: move snapshot-handling functions to snapshot.c
Date: Wed, 2 Nov 2005 00:53:24 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200510301637.48842.rjw@sisk.pl> <200511011929.20073.rjw@sisk.pl> <20051101210452.GH7172@elf.ucw.cz>
In-Reply-To: <20051101210452.GH7172@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511020053.25123.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 1 of November 2005 22:04, Pavel Machek wrote:
> Hi!
> 
> > > > Oh, it can be done on-the-fly in
> > > > sys_put_this_stuff_where_appropriate(image data) (at the expense of one
> > > > redundant check per call).
> > > 
> > > Yes, but it is still ugly, as you keep some context across the
> > > syscalls.
> > 
> > That depends on how you implement the interface.  If you insist on using
> > ioctls then yes, it's ugly.  However, if it is a file in sysfs, for example,
> > then you have well-defined open(), close(), read() and write() operations
> > and it is assumed you will keep some context accross eg. write()s.
> 
> I was trying to keep kernel code simple. Yes, if we do it sysfs based,
> that's probably not a problem. I'm not sure if nice sysfs interface
> can be done without excessive ammount of code.

I'm not sure either, but I'm going to try.

Still first I'd like to make swsusp free only as much memory as needed
and not as much as possible which should improve its performance
quite a bit.

Greetings,
Rafael
