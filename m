Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVBWQzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVBWQzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 11:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVBWQzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 11:55:13 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:8095 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261499AbVBWQzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 11:55:07 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uninterruptible sleep lockups
Date: Wed, 23 Feb 2005 16:55:04 +0000
Message-Id: <022320051655.28959.421CB567000BC5DF0000711F220700164100009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently run into similar issue involving processes stuck in D state - involves khubd and usb-storage. This happens with 2.6.11-rc4.

Check lkml for subject Re: [linux-usb-devel] 2.6: USB Storage hangs mac.. 

Parag


> On Tue, 22 Feb 2005 22:31:03 +0100, Olaf Titz <olaf@bigred.inka.de> wrote:
> > In article <421A3414.2020508@nodivisions.com> you write:
> > > The most recent one was yesterday: I had run lsusb in the morning and had no
> > > problems, but at the end of the day I ran it again, and after outputting 3
> > > lines of data, it hung, stuck in D-state.  So now I have this:
> > >
> > > [/home/user]$ ps aux|grep D
> > > USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> > > root        92  0.0  0.0     0    0 ?        D    Feb19   0:00 [khubd]
> > > root       845  0.0  0.0     0    0 ?        D    Feb19   0:00 [knodemgrd_0]
> > > root     29016  0.0  0.1  1512  592 ?        D    00:28   0:00 lsusb
> > 
> > I'm getting fairly repeatable deadlocks of this kind involving khubd
> > with a USB storage device. Perhaps there's just a faulty locking issue
> > in khubd.
> 
> Would you be willing to file a bugzilla (bugzilla.kernel.org) bug, if
> it's still happening with 2.6.11-rc4? Or, if you have filed one,
> please refer to it?
> 
> Thanks,
> Nish
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
