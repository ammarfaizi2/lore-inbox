Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129327AbRBMVH0>; Tue, 13 Feb 2001 16:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130228AbRBMVHR>; Tue, 13 Feb 2001 16:07:17 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:44706 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S129327AbRBMVHA>; Tue, 13 Feb 2001 16:07:00 -0500
Message-ID: <3A89A1ED.603F0DF8@talk21.com>
Date: Tue, 13 Feb 2001 21:06:53 +0000
From: Scott Ashcroft <scott.ashcroft@talk21.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gordon Sadler <gbsadler1@lcisp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19ac-pre9 lo interface Broke
In-Reply-To: <20010212101318.A6980@home-desktop> <20010213143234.A18024@home-desktop>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gordon Sadler wrote:
> 
> I have some further info here.
> I performed strace on ifup -a and ifdown -a.
> 
> They aren't more than 4Kb each, but I'll cut and paste what appear to be
> most relevant:
> 
> ifup.strace:
> fork()                                  = 17974
> wait4(17974, [WIFEXITED(s) && WEXITSTATUS(s) == 0], 0, NULL) = 17974
> --- SIGCHLD (Child exited) ---
> fork()                                  = 17976
> wait4(17976, SIOCSIFADDR: Bad file descriptor
> lo: unknown interface: Bad file descriptor
> lo: unknown interface: Bad file descriptor
> [WIFEXITED(s) && WEXITSTATUS(s) == 255], 0, NULL) = 17976
> --- SIGCHLD (Child exited) ---
[snip]
> 
> Can anyone point a finger?

Debian bug #85774
http://cgi.debian.org/cgi-bin/bugreport.cgi?archive=no&bug=85774

ifconfig broke, nothing to do with the kernel.

Cheers,
Scott
