Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTKOSuf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 13:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTKOSuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 13:50:35 -0500
Received: from main.gmane.org ([80.91.224.249]:20706 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261898AbTKOSue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 13:50:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Parick Beard <patrick@p-beard.com>
Subject: Re: 2.6.0-test9 VFAT problem
Date: Sat, 15 Nov 2003 18:06:22 +0000
Message-ID: <pan.2003.11.15.18.06.22.23429@p-beard.com>
References: <20031114113224.GR21265@home.bofhlet.net> <bp2mab$sts$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to put this thread on hold
> until I take stock of the steps I've taken just to make sure I've not been a
> right 'plum'.

Hi,
Right, I'm not sure if I've been a 'plum' or not. In fact I'm not sure
about anything now.
Friday when I got home I tried to mount my belkin reader with sda in the
fstab. I got 'no media found'. I then tried to mount my Olympus camera and
got 'wrong fs...'. I changed my fstab to sda1 and tried again. This gave
the same two errors. I rebooted the pc and this time I could mount the
camera, but the belkin usb reader still gave 'no media found'. I then put
the original inode.c back into my source and recompiled. And to my
complete surprise the camera mounted. The belkin however gave 'no media
found'.
All the above would suggest I've been a 'plum' - however I've done this
before with 2.4.  I do tend to be able to get things working by reading
and not bothering good people like yourselves.

Now I have done some further tests and I have found something strange. I
can mount my camera with a 64mb and 16mb smart media. The belkin reader,
if I put the 64mb card in, I get 'no media found'. If I then put the 16mb
card in I also get 'no media found'. If I disconnect and reconnect the
belkin I can mount the 16mb card. If I then put the 64mb in I get 'no
media found'. Putting the 16mb back in gives 'no media found'.
disconnecting and reconnecting the reader allows me to mount the 16mb card.

What I'm trying to say is the reader won't mount the 64mb card. I could
mount it with no problems under 2.4 with this reader. 
The other strange thing is that prior to me patching inode.c both the
camera and reader gave the same 'wrong fs...' errors with the 64mb card.
Yet as I've said I put the original inode.c back and recompiled. yet the
reader with the 64mb card will only give 'no media found'.

with the 64mb card mounted in the camera fdisk -l /dev/sda give me this;

/dev/sda1	*	1	500	63972+	1	FAT12

Any advice would be appreciated.

__
Patrick

