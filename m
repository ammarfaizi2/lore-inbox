Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270984AbTGPRO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270990AbTGPRNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:13:43 -0400
Received: from a213-22-134-227.netcabo.pt ([213.22.134.227]:18048 "EHLO hobbes")
	by vger.kernel.org with ESMTP id S270989AbTGPRNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:13:05 -0400
Date: Wed, 16 Jul 2003 18:27:58 +0100
From: Nuno Monteiro <nuno.monteiro@ptnix.com>
To: linux-kernel@vger.kernel.org
Subject: woes with 2.6.0-test1 and xscreensaver/xlock
Message-ID: <20030716172758.GA1792@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there people,


Is anyone else having trouble with xscreensaver/xlock under 2.6.0-test1? 
Whenever I lock my session using either "lock screen" from the menu (it 
launches 'xscreensaver lock', afaik) or "xlock", I cant seem to ever get 
my session back -- I type in the correct password, but they both just 
hang there. The exact same setup works flawlessly in 2.4.21, and just for 
the sake of curiosity I also tested 2.5.75, 2.5.74, 2.5.73, 2.5.72, 
2.5.71 and 2.5.70, they all exhibit the same behaviour as 2.6.0-test1. I 
dont really have time to go on testing kernels to find out exactly where 
it broke, so I'm hoping anyone else is experiencing these woes.

Additionally, syslog spews out the following:

Jul 16 17:40:24 hobbes xscreensaver(pam_unix)[1501]: authentication 
failure; logname= uid=501 euid=501 tty=:0.0 ruser= rhost=  user=nuno

I upgraded to the latest pam and xscreensaver packages from mandrake 
cooker, but still no dice, it hangs exactly the same. And oh, this is 
glibc 2.3.2, if thats interesting, and gcc 3.3.

Interestingly enough, sometimes killing the xscreensaver process leads to 
a complete hang, although no oops is visible. With nmi_watchdog=1 it 
doesnt hang, but it seems the keyboard is dead after killing xscreensaver 
-- i see an error on console, something like 'xscreensaver: no interrupt 
data for mouse/keyb on /proc/interrupt' (i didnt copy it down, sorry). 
The keyboard is still useable from the console, but not from X.

Let me know if you need more info.


Regards,


		Nuno