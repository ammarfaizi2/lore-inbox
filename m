Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261487AbRFBVgd>; Sat, 2 Jun 2001 17:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbRFBVgX>; Sat, 2 Jun 2001 17:36:23 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2564 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S261487AbRFBVgS>;
	Sat, 2 Jun 2001 17:36:18 -0400
Message-ID: <20010602105249.A979@bug.ucw.cz>
Date: Sat, 2 Jun 2001 10:52:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Reading from /dev/fb0 very slow?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I did some benchmarks, and my framebuffer is *way* faster when writing
than when reading:

root@bug:/home/pavel# time cat /tmp/test > /dev/fb0
0.01user 0.08system 0.09 (0m0.097s) elapsed 93.13%CPU
root@bug:/home/pavel# time cat /dev/fb0 > /dev/null
0.00user 0.62system 0.62 (0m0.620s) elapsed 99.93%CPU
root@bug:/home/pavel#

That is 6 times slower! This is also very visible in X, where moving
regions is expensive, while just drawing regions is fast. For example
gnome-terminal is *way* faster *with* transparent background option.

Any idea why such assymetry? [This is toshiba 4030cdt with vesafb and
2.4.5]

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
