Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbUKEF7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbUKEF7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 00:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbUKEF7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 00:59:45 -0500
Received: from mproxy.gmail.com ([216.239.56.245]:7049 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262613AbUKEF7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 00:59:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mc5UekqyAlAH7+4JYwQ2Oa27sQq/N/4UBhktey+WwoTKuguqsFvH+mSBqzqtie2iLA8Nv5hbeVPsiU8RS1Woy0FJVKy5SZoRgORz3gdjuFeXq8pHDriw0fzb1078wiFfP38hzKXRSnybqrqg//O/uNQ28IG+okF8nNdI2OdNPdY=
Message-ID: <21d7e99704110421597deb381c@mail.gmail.com>
Date: Fri, 5 Nov 2004 16:59:31 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: John McGowan <jmcgowan@inch.com>
Subject: Re: Kernel 2.6.9: i810 video
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20041104172521.I42459@shell.inch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <21d7e99704110314156bb270de@mail.gmail.com>
	 <20041102215308.GA3579@localhost.localdomain>
	 <20041103234045.G92772@shell.inch.com> <418AA075.3070303@tmr.com>
	 <20041104172521.I42459@shell.inch.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> By the way, the X server runs. There is no problem with that.
> 
> If I start it (say, with ICE as a window manager starting up an xterm)
> *immediately after boot* I get a clean, black screen. It should be dark
> green. I get the frame for the xterm. No xterm. I can right click to get
> the menu to display on the screen but it gets locked there. I can right
> click again to get a working menu and choose to logout.
> 
> If I do something befor starting it, the screen is filled with junk.
> Something is writing to the video ram. If I close it and restar it,
> different junk.
> 
> It seems that the initialization of the i810 is leaving its video ram
> free to be grabbed and used.

Can you throw your .config this way as well, I've just built 2.6.9
with i810 drm and no i810 framebuffer (CONFIG_DRM_I810 and
!CONFIG_FB_I810) and played tuxracer just fine for a few minutes under
a gnome session on a Fedora core 1 box with a prerelease of Xorg
6.8... (my i810 test machine doesn't get taken out all that often...)

I did just modprobe the i810 framebuffer module I also built and try
to start X and X wouldn't start with a unable to bind system texture
memory,.... so trying building a kernel without i810 framebuffer
switched on a see what happens..

Dave.
>
