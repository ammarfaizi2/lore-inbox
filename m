Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270977AbTGWIDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 04:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271134AbTGWIDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 04:03:38 -0400
Received: from pop.gmx.net ([213.165.64.20]:35803 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270977AbTGWIDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 04:03:34 -0400
Date: Wed, 23 Jul 2003 13:48:11 +0530
From: Apurva Mehta <apurva@gmx.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
Message-ID: <20030723081811.GA1324@home.woodlands>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20030722013443.GA18184@netnation.com> <20030722172858.GB2880@home.woodlands> <1058899713.733.6.camel@teapot.felipe-alfaro.com> <20030722203716.GA1321@home.woodlands> <20030722213326.GB1176@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722213326.GB1176@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Fedyk <mfedyk@matchmail.com> [2003-07-23 12:00]:

[snip]
> > I just patched my tree and compiled it. It does not work.. It freezes
> > the system when I try to start X.. I gives a huge error message and
> > the last line is something like :
> > <6>note: X[1306] exited with preempt_count 1
> > 
> > I checked all the logs and I cannot find the complete error message
> > anywhere. Any suggestions where to look? 
> 
> How about your Xfree86 log?  (probably somewhere in /var/log)

I stumbled accross something very interesting today morning while
trying to start X on 2.6.0-test1-mm2. If I login on the console and
then execute a simple command like 'ls' and then do a `startx`, it
works. But if login and immediately do a `startx` (without any
preceding command), I get that error. Very strange.

The problems do not end there. Once I start X, I experience
random freezes of the system. In one session I could play some music
and write some email. It froze just after dialing into the
internet. In another session it froze while trying to start xmms.

After the system freezes in X and when I reboot into mm2, I get an error
message like I described in my previous mail just after all the init
scripts have started. The system then freezes again. On the subsequent
reboot, I can login.

The Xfee86 logs (XFree86.0.log and XFree86.0.log.old) do not contain
anything relavent. I checked /var/log/messages and it has nothing either.

	- Apurva
