Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267884AbTGHWpg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267886AbTGHWpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:45:36 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:49675 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267884AbTGHWpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:45:25 -0400
Date: Tue, 8 Jul 2003 23:59:58 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Pavel Machek <pavel@suse.cz>
cc: vojtech@suse.cz,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Small cleanups for input
In-Reply-To: <20030624101017.GD159@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0307082359160.32323-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This needs to be migrated to the new power management code.

> ===================================================================
> --- linux.orig/drivers/input/power.c	2003-06-24 11:54:39.000000000 +0200
> +++ linux/drivers/input/power.c	2003-04-18 16:19:02.000000000 +0200
> @@ -45,9 +45,7 @@
>  static int suspend_button_pushed = 0;
>  static void suspend_button_task_handler(void *data)
>  {
> -        //extern void pm_do_suspend(void);
>          udelay(200); /* debounce */
> -        //pm_do_suspend();
>          suspend_button_pushed = 0;
>  }
>  
> @@ -67,8 +65,6 @@
>  			case KEY_SUSPEND:
>  				printk("Powering down entire device\n");
>  
> -				//pm_send_all(PM_SUSPEND, dev);
> -
>  				if (!suspend_button_pushed) {
>                  			suspend_button_pushed = 1;
>                          		schedule_work(&suspend_button_task);
> 
> 

