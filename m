Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131974AbRDJXlk>; Tue, 10 Apr 2001 19:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbRDJXla>; Tue, 10 Apr 2001 19:41:30 -0400
Received: from marine.sonic.net ([208.201.224.37]:632 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S131974AbRDJXlM>;
	Tue, 10 Apr 2001 19:41:12 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 10 Apr 2001 16:41:09 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010410164109.A1766@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010405000215.A599@bug.ucw.cz> <9b04fo$9od$3@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
In-Reply-To: <9b04fo$9od$3@ncc1701.cistron.net>; from miquels@cistron-office.nl on Tue, Apr 10, 2001 at 11:20:24PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 11:20:24PM +0000, Miquel van Smoorenburg wrote:
> In article <20010405000215.A599@bug.ucw.cz>,
> Pavel Machek  <pavel@suse.cz> wrote:
> >Init should get to know that user pressed power button (so it can do
> >shutdown and poweroff). Plus, it is nice to let user know that we can
> 
> Not so hasty ;)
> 
> >+		printk ("acpi: Power button pressed!\n");
> >+		kill_proc (1, SIGTERM, 1);

[reasons deleted]

Is using a signal the appropriate thing to do anyway?

Wouldn't there be better solutions?

Perhaps a mechanism a user space program can use to communicate to the kernel
(ala arpd/kerneld message queues, or something like klogd).  Then a more
general user space tool could be used that would do policy appropriate
stuff, ending with init 0.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
