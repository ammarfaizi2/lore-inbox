Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVKLXsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVKLXsS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbVKLXsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:48:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39075 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964862AbVKLXsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:48:18 -0500
Date: Sat, 12 Nov 2005 21:39:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Bj?rn Mork <bmork@dod.no>, linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051112203935.GA1594@elf.ucw.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no> <200511121023.23245.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511121023.23245.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is unlikely... serio has the proper support for freezing as
> far as I understand:
> 
> static int serio_thread(void *nothing)
> {
>         do {
>                 serio_handle_events();
>                 wait_event_interruptible(serio_wait,
>                         kthread_should_stop() || !list_empty(&serio_event_list));
>                 try_to_freeze();
>         } while (!kthread_should_stop());
> 
>         printk(KERN_DEBUG "serio: kseriod exiting\n");
>         return 0;
> }
> 
> Pavel, any ideas?

No ideas... it works for me on x32.
							Pavel
-- 
Thanks, Sharp!
