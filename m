Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWABH3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWABH3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 02:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWABH3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 02:29:52 -0500
Received: from main.gmane.org ([80.91.229.2]:23179 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932329AbWABH3w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 02:29:52 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: SysReq & serial console
Date: Mon, 02 Jan 2006 16:29:38 +0900
Message-ID: <dpakp2$tip$3@sea.gmane.org>
References: <43B8696B.2070303@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
In-Reply-To: <43B8696B.2070303@gmx.de>
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reinhard Nissl wrote:
> Hi,
> 
> I'm facing a similar issue like the thread
> 
> system keeps freezing once every 24 hours / random apps crashing
> 
> reported, but I still have to try all those suggestions.
> 
> For now, I've configured a serial console and enabled SysReq. When the
> freeze happens on my system, the system is still pingable and SysReq can
> for example sync the disks. I also can see on serial console which
> SysReq command I selected (registers, tasks, SAK, etc.), but I do not
> get any output of these commands on serial console.
> 
> When issuing such a SysReq command before the system freezes I can see
> the output of the command on a framebuffer console.
> 
> So, is it possible to redirect the output of a SysReq command to a
> serial console?
Another wild guess: the syslog is still running and writes the output to the log.
I had this "problem" with syslog-ng running on 2.6.14.4. The solution was to set syslog-ng to write
to tty1 as well (now moved to tty12 to not scramble other MSGs).
I was seeing just something like "SysRq: memory map" and now I can see the output below that MSG.

Not sure if that was inteded to do so, but I think the output of SysRq+<key> is better send to the
console directly...

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

