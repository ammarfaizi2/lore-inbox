Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVAJHoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVAJHoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 02:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVAJHod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 02:44:33 -0500
Received: from asclepius3.uwa.edu.au ([130.95.128.60]:61575 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id S262137AbVAJHo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 02:44:29 -0500
X-UWA-Client-IP: 130.95.13.9 (UWA)
Date: Mon, 10 Jan 2005 15:44:22 +0800
From: bernard@blackham.com.au
To: Pavel Machek <pavel@ucw.cz>
Cc: Shaw <shawv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: Screwy clock after apm suspend
Message-ID: <20050110074422.GA17710@mussel>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com> <20050109224711.GF1353@elf.ucw.cz> <200501092328.54092.shawv@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501092328.54092.shawv@comcast.net>
User-Agent: Mutt/1.5.6+20040818i
X-SpamTest-Info: Profile: Formal (192/041231)
X-SpamTest-Info: Profile: Detect Hard [UCS 290904]
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (UCS) [02-08-04]
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0125], KAS/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 11:28:53PM -0800, Shaw wrote:
> On Sunday 09 January 2005 02:47 pm, Pavel Machek wrote:
> > Probably code to compensate clock after ACPI suspend breaks apm case
> >
> > arch/i386/kernel/time.c, can you comment out
> > jiffies += sleep_length * HZ;
> >
> > in timer_resume to see if it goes away?
> 
> Worked like a charm.  I'm not seeing any time drift after your suggested 
> change.

AIUI, this also means that a machine's uptime does not include time
whilst suspended. This was the behaviour prior to 2.6.10 and seems to be
more desirable as it counts the time the machine is actually running,
not just time since boot. Is there a good reason why we can't go back to
this?

Bernard.

