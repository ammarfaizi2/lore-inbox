Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBMUaJ>; Tue, 13 Feb 2001 15:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRBMU3u>; Tue, 13 Feb 2001 15:29:50 -0500
Received: from cm-24-142-168-193.lawton.ispchannel.com ([24.142.168.193]:33799
	"EHLO localhost") by vger.kernel.org with ESMTP id <S129057AbRBMU31>;
	Tue, 13 Feb 2001 15:29:27 -0500
Date: Tue, 13 Feb 2001 14:32:34 -0600
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19ac-pre9 lo interface Broke
Message-ID: <20010213143234.A18024@home-desktop>
In-Reply-To: <20010212101318.A6980@home-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010212101318.A6980@home-desktop>; from gbsadler on Mon, Feb 12, 2001 at 10:13:18AM -0600
From: Gordon Sadler <gbsadler1@lcisp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some further info here.
I performed strace on ifup -a and ifdown -a.

They aren't more than 4Kb each, but I'll cut and paste what appear to be
most relevant:

ifup.strace:
fork()                                  = 17974
wait4(17974, [WIFEXITED(s) && WEXITSTATUS(s) == 0], 0, NULL) = 17974
--- SIGCHLD (Child exited) ---
fork()                                  = 17976
wait4(17976, SIOCSIFADDR: Bad file descriptor
lo: unknown interface: Bad file descriptor
lo: unknown interface: Bad file descriptor
[WIFEXITED(s) && WEXITSTATUS(s) == 255], 0, NULL) = 17976
--- SIGCHLD (Child exited) ---

ifdown.strace:
munmap(0x40018000, 4096)                = 0
fork()                                  = 17989
wait4(17989, [WIFEXITED(s) && WEXITSTATUS(s) == 0], 0, NULL) = 17989
--- SIGCHLD (Child exited) ---
fork()                                  = 17991
wait4(17991, lo: unknown interface: Bad file descriptor
[WIFEXITED(s) && WEXITSTATUS(s) == 255], 0, NULL) = 17991
--- SIGCHLD (Child exited) ---

I think a better question would be, does anyone here have any ideas
where I might look to correcting this? Since it did not occur with same
tools under 2.2.18pre24, should I assume the kernel is at fault and look
there? Or maybe the eepro module code? I notice quite a bit of
discussion concerning this driver, but all (?) relating to 2.4.x

Can anyone point a finger?

Thanks
Gordon Sadler
