Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263422AbTEITgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 15:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbTEITgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 15:36:10 -0400
Received: from [65.244.37.61] ([65.244.37.61]:60289 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S263422AbTEITgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 15:36:09 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A92020CD8B9@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: Andy Pfiffer <andyp@osdl.org>, walt <wa1ter@hotmail.com>
Cc: Torrey Hoffman <thoffman@arnor.net>, Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: ALSA busted in 2.5.69
Date: Fri, 9 May 2003 15:48:08 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Andy Pfiffer [mailto:andyp@osdl.org]
> On Fri, 2003-05-09 at 11:14, walt wrote:
>> Torrey Hoffman wrote:
>> > On Fri, 2003-05-09 at 01:09, Giuliano Pochini wrote:
>> > 
>> >>On 08-May-2003 Torrey Hoffman wrote:
>> >>
>> >>>ALSA isn't working for me in 2.5.69.  It appears to be because
>> >>>/proc/asound/dev is missing the control devices.
>> > ...
>> >>If you are not using devfs, you need to create the devices. There is a
>> >>script in the ALSA-driver package to do that. Otherwise I can't help
>> >>you because I never tried devfs and linux 2.5.x.
>> > 
>> > No.  /dev/snd is a symbolic link to /proc/asound/dev,
>> > and that symbolic link was created by the script you mention.
>> > (I am not using devfs.)
>
> I'm not using devfs, and I've had no luck getting ALSA to work on my
> i810-audio system.  OSS works fine.
>
> Is there a step-by-step writeup available for morons like me that
> haven't gotten ALSA working?
>
> Thanks,
> Andy

I have i810 working on my machine -

1.) You may have already done this - but here it is:  Go to
www.alsa-project.org, under "New Users" click on "Supported Soundcars"
On this page, find the Intel i810 listing, and click on "Details".
Follow all instructions _carefully_.  (I created the devices by
hand - this script didn't work correctly for me.)  Make sure that
both the char-major-14 and char-major-116 devices exist. (14 is OSS
and 116 is ALSA.)  Make sure the aliases are correct in modprobe.conf.

2.) After that, (or if you've already done that), use amixer to look
at and set the sound controls for your card.  NOTE:  the i810 driver
has a "gotcha".  To set the volume for the line out jack on you PC
you will probably have to use the "Headphone" mixer control.  That
little curve ball stumped me till somebody else dropped me the hint.

3.) If all that still doesn'te work, post again.

td
