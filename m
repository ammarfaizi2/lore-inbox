Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287833AbSA2AYJ>; Mon, 28 Jan 2002 19:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287855AbSA2AX6>; Mon, 28 Jan 2002 19:23:58 -0500
Received: from jhuml3.jhu.edu ([128.220.2.66]:22715 "HELO jhuml3.jhu.edu")
	by vger.kernel.org with SMTP id <S287833AbSA2AXr>;
	Mon, 28 Jan 2002 19:23:47 -0500
Date: Mon, 28 Jan 2002 16:14:30 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: 2.4.18-pre7 slow ... apm problem
In-Reply-To: <Pine.LNX.4.44.0201290351520.7623-100000@boston.corp.fedex.com>
To: linux-kernel@vger.kernel.org
Message-id: <1012252470.743.134.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.1
Content-type: text/plain
Content-transfer-encoding: 7bit
In-Reply-To: <Pine.LNX.4.44.0201290351520.7623-100000@boston.corp.fedex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-28 at 15:11, Jeff Chua wrote:
> Sorry, just got off a long flight from San Diego to Singapore. Anyway,
> slow ... means that even without vmware, if I just hit return, the lines
> would scroll for about every 10 lines and there'll be a litte pause (<0.3
> sec). With pre6, there's no such behavior, and if CONFIG_APM_CPU_IDLE is
> not set, the "pause" goes away.

Suggestion: Try setting the idle_threshold to a higher value,
e.g., 98.  (The default value is 95.)

Question to all: Would it be a good idea to de-idle the CPU
inside interrupt handlers?

> "host" system is linux. "guest" system is linux (actually, I tried with NT
> as well, same problem).
> 
> The sympton is when I try to ping the "host" from vmware's "guest" system,
> the first response came back to the guest's console. Then if I don't type
> anything or don't move the mouse on the guest's console, I won't see any
> further response on the guest's linux console. Even with a lot of mouse
> movement or pressing the keys, the response is still very slow with "ping".

> If I ping from the "host" linux console to the "guest" linux system,
> responses came back, and does not hang. I'll double check this last point.
> Got to recompile the kernel again.

Try disabling APM cpu idling (set apm idle_threshold to 100) in the
_guest_ OS.  (Leave it enabled in the host OS.)  Tell us what happens.

Also try disabling APM cpu idling (set apm idle_threshold to 100) in
the _host_ OS.  (Leave it enabled in the guest OS.)  Tell us what
happens.

I repeat: You do not need to recompile the kernel to enable/disable
APM cpu idle: to disable it simply set idle_threshold to 100.



