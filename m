Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVBXDIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVBXDIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 22:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVBXDHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 22:07:40 -0500
Received: from mta9.adelphia.net ([68.168.78.199]:30637 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S261712AbVBXDHW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 22:07:22 -0500
Message-ID: <421D4460.6050308@nodivisions.com>
Date: Wed, 23 Feb 2005 22:05:04 -0500
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: mouse still losing sync and thus jumping around
References: <421C83A2.9040502@vollwerbung.at>	 <d120d50005022306177069ffbe@mail.gmail.com>	 <421CAF7D.9080004@vollwerbung.at> <d120d50005022308536d29dab7@mail.gmail.com>
In-Reply-To: <d120d50005022308536d29dab7@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Yes, It usually happens either under high load, when mouse interrupts are
> significantly delayed. Or sometimes it happen when applications poll
> battey status and on some boxes it takes pretty long time. And because
> it is usually the same chip that serves keyboard/mouse it again delays
> mouse interrupts.

I have this problem with recent 2.6.10 kernels too, but it has nothing to do 
with load in my case; it happens whenever I switch my KVM to the linux box.

Long ago and far away, it used to be that switching out of X, then back in 
(ctrl-alt-F1, then ctrl-alt-F7) would reset the mouse and stop the jumping. 
  At some point in late 2.4/early 2.6 that stopped working, and the only fix 
was to unplug the mouse from the KVM switch and re-plug it.

In Oct 2004 I posted to lkml with subject "KVM -> jumping mouse... still no 
solution?"  Dmitry Torokhov (hi :) responded that this would work on 2.6.9-rc3+:

	echo -n "reconnect" > /sys/bus/serio/devices/serioX/driver

That was GREAT and it worked for a while, but now my last few 2.6.10 kernels 
don't seem to care when I do that, and again, unplugging the mouse is the 
only thing that works.  I'm currently running 2.6.10-gentoo-r6.

-Anthony DiSante
http://nodivisions.com/
