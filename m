Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbRBYWwe>; Sun, 25 Feb 2001 17:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129888AbRBYWwU>; Sun, 25 Feb 2001 17:52:20 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:31441 "HELO
	localdomain") by vger.kernel.org with SMTP id <S129886AbRBYWvx>;
	Sun, 25 Feb 2001 17:51:53 -0500
Message-ID: <XFMail.20010225145315.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010225224039.W13721@redhat.com>
Date: Sun, 25 Feb 2001 14:53:15 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
To: Tim Waugh <twaugh@redhat.com>
Subject: RE: timing out on a semaphore
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25-Feb-2001 Tim Waugh wrote:
> I'm trying to chase down a semaphore time-out problem.  I want to
> sleep on a semaphore until either
> 
> (a) it's signalled, or
> (b) some amount of time has elapsed.
> 
> What I'm doing is calling add_timer, and then down_interruptible, and
> finally del_timer.  The timer's function ups the semaphore.
> 
> The code is in parport_wait_event, in drivers/parport/ieee1284.c.
> 
> Can anyone see anything obviously wrong with it?  It seems to
> sometimes get stuck.

If it's SMP, have You tried to call del_timer_sync() ?




- Davide

