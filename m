Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266389AbRGBHIt>; Mon, 2 Jul 2001 03:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266391AbRGBHIi>; Mon, 2 Jul 2001 03:08:38 -0400
Received: from nic.lth.se ([130.235.20.3]:30867 "EHLO nic.lth.se")
	by vger.kernel.org with ESMTP id <S266389AbRGBHI2>;
	Mon, 2 Jul 2001 03:08:28 -0400
Date: Mon, 2 Jul 2001 09:08:21 +0200
From: Jakob Borg <jakob@borg.pp.se>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Keyboard errors with 2.4.5-ac
Message-ID: <20010702090821.A3084@borg.pp.se>
In-Reply-To: <3B3CBA86.355500A@inet.com> <20010630194835.A730@borg.pp.se> <20010701233942.D22232@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010701233942.D22232@kroah.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux narayan 2.4.5 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2001 at 11:39:42PM -0700, Greg KH wrote:
> On Sat, Jun 30, 2001 at 07:48:36PM +0200, Jakob Borg wrote:
> > You are using an SMP kernel. In my experience, nothing USB works with an SMP
> > kernel >2.4.3.
> 
> Hm, that's a pretty vague statement :)
> I'm happily running USB on a few SMP machines around here.  What are the
> problems that you are having?

Well, the problems I have (had; I'll get to that) are:

* Hard lockup whenever you try to access an USB audio device
* Sudden reboot sometimes when streaming video from an USB webcam.

The first problem appeared in 2.4.3 and only on SMP, but I know work around
that by using the alternate UHCI driver which seems to work well so far. The
second problem persists, but that is probably just a bug in the camera
driver. Nevertheless, all USB devices I tried on { SMP, kernel >2.4.3,
non-alternate UHCI driver } failed, so my statement was correct. :)

Since the alternate UHCI driver works I am satisified, but perhaps someone
interested in the normal driver should look into what happened between 2.4.3
and 2.4.4.

//jb
