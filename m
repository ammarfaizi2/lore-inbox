Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVBWXoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVBWXoD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVBWXTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:19:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:3031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261686AbVBWXPc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:15:32 -0500
Date: Wed, 23 Feb 2005 15:20:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org, helge.hafting@aitel.hist.no
Subject: Re: 2.6.11-rc4-mm1 : IDE crazy numbers, hdb renumbered to hdq ?
Message-Id: <20050223152038.08f7d7e0.akpm@osdl.org>
In-Reply-To: <421D0582.9090100@free.fr>
References: <20050223014233.6710fd73.akpm@osdl.org>
	<421C7FC2.1090402@aitel.hist.no>
	<20050223121207.412c7eeb.akpm@osdl.org>
	<421D0582.9090100@free.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard <laurent.riffard@free.fr> wrote:
>
> Le 23.02.2005 21:12, Andrew Morton a écrit :
> > Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> >
> >>This kernel came up, but my boot script complained about no /dev/hdb3
> >> when trying to mount /var.
> >> (I have two IDE disks on the same cable, and an IDE cdrom on another.)
> >> They are usually hda, hdb, and hdc.
> >>
> >> MAKEDEV hdq did not help.  Looking at sysfs, it turns out that
> >> /dev/hdq1 is at major:3 minor:1025 if I interpret things right.
> >> (/dev/hda1 is at 3:1, which is correct.)
> >> These numbers did not work with my mknod, it created 7:1 instead.
> >> So I didn't get to test this mysterious device.
> >>
> >> But I assume this is a mistake of some sort, I haven't heard about any
> >> change in the IDE numbering coming up?  2.6.1-rc3-mm1 works as expected.
> >>
> >> It may be interesting to note that my root raid-1 came up fine,
> >> consisting of hdq1 and hda1 instead of the usual hdb1 and hda1.
> >
> >
> > I don't know what could be causing that.  Please send .config.  If you set
> > CONFIG_BASE_FULL=n, try setting it to `y'.
> >
> 
> this is just a "me too"...

Confusing.  Are you saying that the hdd->hdq problem is happening even with
CONFIG_BASE_FULL=y?

