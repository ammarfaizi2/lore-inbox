Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUL2BQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUL2BQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 20:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUL2BQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 20:16:47 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:63144 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261273AbUL2BQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 20:16:23 -0500
Subject: Re: Screwy clock after apm suspend
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Brannon Klopfer <plazmcman@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <41D1FA78.50203@softhome.net>
References: <41D1FA78.50203@softhome.net>
Content-Type: text/plain
Message-Id: <1104283084.16753.16.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 29 Dec 2004 12:18:05 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

We've seen this problem with Suspend2 as well. One of my Suspend2 users
has looked into the problem and suggested a couple of solutions; I'll
take a look at them shortly and send a patch here as well.

Regards,

Nigel

On Wed, 2004-12-29 at 11:29, Brannon Klopfer wrote:
> 2.6.10
> Slackware 10/-current
> IBM ThinkPad 600E
> ----------------
> 
> 2.6.10 screws up my system clock.
> Two kernel/hardware clock readings, before and after suspend.
> -------------
> plaz@gonzo:~$ date ;hwclock
> Tue Dec 28 15:52:39 PST 2004
> Tue Dec 28 14:54:07 2004 -0.503621 seconds
> #suspend, resume
> plaz@gonzo:~$ date ;hwclock
> Tue Dec 28 16:11:58 PST 2004
> Tue Dec 28 15:04:06 2004 -0.168262 seconds
> ---------------------
> These are all when the comp is on without suspend (difference about the 
> same throughout).
> ----------------
> plaz@gonzo:~$ date ;hwclock
> Tue Dec 28 16:14:52 PST 2004
> Tue Dec 28 15:07:00 2004 -0.251812 seconds
> plaz@gonzo:~$ date ;hwclock
> Tue Dec 28 16:15:26 PST 2004
> Tue Dec 28 15:07:34 2004 -0.236138 seconds
> plaz@gonzo:~$ date ;hwclock
> Tue Dec 28 16:19:48 PST 2004
> Tue Dec 28 15:11:57 2004 -0.908540 seconds
> plaz@gonzo:~$
> ------------
> I did not have this problem with 2.6.9. My machine uses APM, clock 
> stores local time (specified in kernel config). I use PIT for 
> timesource, as others were losing ticks when on battery power (changes 
> CPU clock speed). Again, did _not_ have this problem with 2.6.9.
> 
> Be glad to try out patches,
> Brannon Klopfer
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
Cyclades Software Engineer
Canberra, Australia

http://www.cyclades.com

+61 (2) 6292 8028
+61 (417) 100 574

