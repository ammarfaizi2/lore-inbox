Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbTGHXAE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbTGHXAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:00:04 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:36033 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S265474AbTGHXAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:00:00 -0400
Date: Wed, 9 Jul 2003 01:14:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: vojtech@suse.cz,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Small cleanups for input
Message-ID: <20030708231419.GA619@elf.ucw.cz>
References: <20030624101017.GD159@elf.ucw.cz> <Pine.LNX.4.44.0307082359160.32323-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307082359160.32323-100000@phoenix.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This needs to be migrated to the new power management code.

What exactly should it do? Suspend machine? Then it needs to do
equivalent of "echo 3 > /proc/acpi/sleep", but I do not think we have
generic interface for that...

Perhaps some comment should be put there?
								Pavel

> > ===================================================================
> > --- linux.orig/drivers/input/power.c	2003-06-24 11:54:39.000000000 +0200
> > +++ linux/drivers/input/power.c	2003-04-18 16:19:02.000000000 +0200
> > @@ -45,9 +45,7 @@
> >  static int suspend_button_pushed = 0;
> >  static void suspend_button_task_handler(void *data)
> >  {
> > -        //extern void pm_do_suspend(void);
> >          udelay(200); /* debounce */
> > -        //pm_do_suspend();
> >          suspend_button_pushed = 0;
> >  }
> >  
> > @@ -67,8 +65,6 @@
> >  			case KEY_SUSPEND:
> >  				printk("Powering down entire device\n");
> >  
> > -				//pm_send_all(PM_SUSPEND, dev);
> > -
> >  				if (!suspend_button_pushed) {
> >                  			suspend_button_pushed = 1;
> >                          		schedule_work(&suspend_button_task);
> > 
> > 
> 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
