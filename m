Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVAHKAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVAHKAd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 05:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVAHJ7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:59:49 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:53454 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261918AbVAHJ4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 04:56:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GiXYQv7m1/iQpMcEaBBk7Dq0cQcLgOFcJA8vhtTYjA5XxHhBMIyBkTEihgetZKs3aNsIP3OmuSUc5Cz2swaVH1LmjzBkzTtEGTS+FwVq7cT2WFNiQk+VxVPj2ZU1mGzZUuo4mg2gmbSff31zHz7mLrhcdYPvO4th1sV+shwYyH4=
Message-ID: <297f4e010501080156736e929e@mail.gmail.com>
Date: Sat, 8 Jan 2005 10:56:49 +0100
From: Ikke <ikke.lkml@gmail.com>
Reply-To: Ikke <ikke.lkml@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: kobject_uevent
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050107233632.GA1467@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <297f4e01050107065060e0b2ad@mail.gmail.com>
	 <297f4e0105010713254b6e0678@mail.gmail.com>
	 <20050107233632.GA1467@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, events are sent to DBUS now, including the additional string
information [1]. Code (for now, it's not "done" yet!) is here [2].

I'll ask the DBUS guys whether it's usefull to get this (optionally)
directly into DBUS.

Let's hope other kernel devs will also start introducing events into
their code! :-)

Greetings, Ikke

[1] http://blog.eikke.com/index.php/ikke/2005/01/08/udev_kernel_events_part_2
[2] http://www.eikke.com/files/code/uevent_listen.c


On Fri, 7 Jan 2005 15:36:32 -0800, Greg KH <greg@kroah.com> wrote:
> On Fri, Jan 07, 2005 at 10:25:14PM +0100, Ikke wrote:
> > I'm a little confused by the use of KOBJ_* stuff in
> > include/linux/kobject_uevent.h and the string representation of them
> > in lib/kobject_uevent.c, which means people must edit 2 files if they
> > want to add new events?
> 
> Yes, that is exactly correct.  The enumerated type is used for the
> callers to kobject_uevent* and the string is sent out on the wire from
> within the kevent core code.
> 
> Hope this helps,
> 
> greg k-h
>
