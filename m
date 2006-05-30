Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWE3TvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWE3TvO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWE3TvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:51:14 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:23027 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932452AbWE3TvM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:51:12 -0400
Date: Tue, 30 May 2006 10:40:20 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Jon Smirl <jonsmirl@gmail.com>
cc: Dave Airlie <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> 
 <200605272245.22320.dhazelton@enter.net>  <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
  <200605280112.01639.dhazelton@enter.net>  <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
 <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2006, Jon Smirl wrote:

>> b) loading fbdev drivers breaks X in a lot of cases, we need to be a
>> bit more careful.
>
> It is perfectly legal to load an fbdev driver with X today. If it
> doesn't work it is a bug in X and should be fixed.
>
>> c) Lots of distros don't use fbdev drivers, forcing this on them to
>> use drm isn't an option.
>
> Why isn't this an option? Will the distros that insist on continuing
> to ship three conflicting video drivers fighting over a single piece
> of hardware please stand up and be counted? Distros get new drivers
> all the time, why will this be any different?

as a long time linux user I tend to not to use the framebuffer, but 
instead use the standard vga text drivers (with X and sometimes dri/drm).

in part this dates back to my early experiances with the framebuffer code 
when it was first introduced, but I still find that the framebuffer is not 
as nice to use as the simpler direct access for text modes. and when I 
start X up it doesn't need a framebuffer, so why suffer with the 
performance hit of the framebuffer?

yes, some hardware requires a framebuffer to display anything, but for 
most video cards, the hardware scrolling of a pure text mode is better 
(faster, smoother, less cpu required, etc) then the framebuffer 
equivalent.

David Lang
