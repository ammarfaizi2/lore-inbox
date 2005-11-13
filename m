Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVKMBxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVKMBxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 20:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVKMBxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 20:53:19 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:3183 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750716AbVKMBxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 20:53:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Date: Sat, 12 Nov 2005 20:53:11 -0500
User-Agent: KMail/1.8.3
Cc: Bj?rn Mork <bmork@dod.no>, linux-kernel@vger.kernel.org
References: <87zmoa0yv5.fsf@obelix.mork.no> <200511121023.23245.dtor_core@ameritech.net> <20051112203935.GA1594@elf.ucw.cz>
In-Reply-To: <20051112203935.GA1594@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511122053.11630.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 November 2005 15:39, Pavel Machek wrote:
> Hi!
> 
> > This is unlikely... serio has the proper support for freezing as
> > far as I understand:
> > 
> > static int serio_thread(void *nothing)
> > {
> >         do {
> >                 serio_handle_events();
> >                 wait_event_interruptible(serio_wait,
> >                         kthread_should_stop() || !list_empty(&serio_event_list));
> >                 try_to_freeze();
> >         } while (!kthread_should_stop());
> > 
> >         printk(KERN_DEBUG "serio: kseriod exiting\n");
> >         return 0;
> > }
> > 
> > Pavel, any ideas?
> 
> No ideas... it works for me on x32.

Hmm, I just suspended/resumed twice in a row, everything wokrs just fine.
I also have a touchpoad and a trackpoint, as does the original poster...

-- 
Dmitry
