Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265054AbSJ3Xbj>; Wed, 30 Oct 2002 18:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265062AbSJ3Xbj>; Wed, 30 Oct 2002 18:31:39 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:52203 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S265054AbSJ3Xbg>; Wed, 30 Oct 2002 18:31:36 -0500
Message-Id: <200210310035.g9V0ZI5e001324@pool-141-150-241-241.delv.east.verizon.net>
Date: Wed, 30 Oct 2002 19:35:16 -0500
From: Skip Ford <skip.ford@verizon.net>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: post-halloween 0.2
References: <20021030171149.GA15007@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021030171149.GA15007@suse.de>; from davej@codemonkey.org.uk on Wed, Oct 30, 2002 at 05:11:49PM +0000
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [141.150.241.241] at Wed, 30 Oct 2002 17:37:56 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> I updated the list of various things that wannabe testers might hit.
> If theres something I missed let me know, and I'll get it right
> next time round..
> 
> Deprecated features:
> ~~~~~~~~~~~~~~~~~~~~
> - khttpd is gone.
> - Older Direct Rendering Manager (DRM) support (For XFree86 4.0)
>   has been removed. Upgrade to XFree86 4.1.0 or higher.

Anyone that uses multimedia keys without X will see changes in how the
kernel handles those keys.  People who customize keymaps or keycodes in
2.4 may need to make some changes to those scripts in 2.5

A new keyboard package was released, but I haven't tested it yet to make
sure everything works.  I hacked up loadkeys and setkeycodes on my own
to get it to work, and I just haven't upgraded to the new package yet.

> Input layer
> ~~~~~~~~~~~
> Possibly the most visible change to the end user. If misconfigured,
> you'll find that your keyboard/mouse/other input device will no longer work.
> 2.5 offers a much more flexable interface to devices such as keyboards.
> The downside is more confusing options.
> In the "Input device support" menu, be sure to enable at least the following.
> 
>                     --- Input I/O drivers
>                     < > Serial i/o support
>                     < >   i8042 PC Keyboard controller
>                     [ ] Keyboards
>                     [ ] Mice
> 
> (Also choose the relevant keyboard/mouse from the list)
> 
> If you find your keyboard/mouse still don't work, edit the file
> drivers/input/serio/i8042.c, and replace the #undef DEBUG
> with a #define DEBUG
> 
> When you boot, you should now see a lot more debugging information.
> Forward this information to Vojtech Pavlik <vojtech@suse.cz>
> 
> If you use a KVM switcher, and experience problems, booting
> with the boot time argument 'psmouse_noext' should fix your
> problems.

-- 
Skip
