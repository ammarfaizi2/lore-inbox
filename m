Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVABGwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVABGwg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 01:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVABGwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 01:52:36 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:54451 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261212AbVABGwd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 01:52:33 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Date: Sun, 2 Jan 2005 01:52:32 -0500
User-Agent: KMail/1.6.2
Cc: Roey Katz <roey@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org> <200501011631.36884.dtor_core@ameritech.net> <Pine.NEB.4.61.0501020622080.16181@sdf.lonestar.org>
In-Reply-To: <Pine.NEB.4.61.0501020622080.16181@sdf.lonestar.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200501020152.32207.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 January 2005 01:28 am, Roey Katz wrote:
> On Sat, 1 Jan 2005, Dmitry Torokhov wrote:
> 
> > What does /proc/bus/input/devices show? Do you have Synaptics touchpad/
> > driver in your box?
> 
> Dmitry,
> 
> I do not have a Synaptics touchpad on this computer nor do I have the 
> driver installed (though all I know is 'grep SYN .config' returned 
> empty, so I may be mistaken).  Does the Synaptics driver mess with the 
> keyboard at all?
>

Not exactly - Synaptics X driver "grabs" the device it uses so other
processes do not get any data from the touchpad when its active. When
keyboard and mouse initialization got swapped around many people who
were specifying /dev/input/event0 as a device were in for surprise as
the driver "grabbed" keyboard making it impossible to type.

> 
> Regarding /proc/bus/input/devices, listing (a) is from 2.6.7 and (b) is 
> from 2.6.10.  Note that the mouse and keyboard have switched devices 
> (event0 and event1) between kernel versions.  Does this affect it at all 
> maybe? BTW, I do have a USB Wacom tablet attached.  Interestingly, 2.6.7 
> does not seem to list it in /proc/bus/input/devices.
> 

Does the keyboard work when you are not in X (like when booting to
runlevel 3)? It looks like everything is detected correctly...

-- 
Dmitry
