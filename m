Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261334AbTC0TD4>; Thu, 27 Mar 2003 14:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261348AbTC0TD4>; Thu, 27 Mar 2003 14:03:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:27310 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261334AbTC0TDy>;
	Thu, 27 Mar 2003 14:03:54 -0500
Date: Thu, 27 Mar 2003 12:17:09 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Greg KH <greg@kroah.com>
cc: Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>,
       <azarah@gentoo.org>, KML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, <sensors@Stimpy.netroedge.com>
Subject: Re: lm sensors sysfs file structure
In-Reply-To: <20030327185222.GI32667@kroah.com>
Message-ID: <Pine.LNX.4.33.0303271214380.1001-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Btw, is it indended behaviour of sysfs, that after writing to a file, 
> > the size is zero?
> 
> Hm, don't know about that, I haven't seen that before.  If you cat the
> file after writing it, does the file size change?

It's a known problem that I haven't been able to track down. 

The file size is hardwired to PAGE_SIZE when it is created. For some 
reason, it's reset to 0 after it's opened. I haven't had a chance to track 
down why, or how to reset it..


	-pat

