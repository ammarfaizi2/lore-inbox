Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWGaBbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWGaBbA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 21:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWGaBa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 21:30:59 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:8239 "EHLO
	asav06.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S964803AbWGaBa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 21:30:59 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAIv4zESBUg
From: Dmitry Torokhov <dtor@insightbb.com>
To: liyu <liyu@ccoss.com.cn>
Subject: Re: [PATCH 1/3] usbhid: Driver for microsoft natural ergonomic keyboard 4000
Date: Sun, 30 Jul 2006 21:30:56 -0400
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
References: <44C74708.6090907@ccoss.com.cn> <20060728135428.GC4623@ucw.cz> <44CD536C.3050703@ccoss.com.cn>
In-Reply-To: <44CD536C.3050703@ccoss.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2204
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200607302130.56881.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 20:48, liyu wrote:
> Pavel Machek Wrote:
> > Hi!
> >
> >   
> >>     This new version get some improvements:
> >>
> >>     2. Support left paren key "(", right paren key ")", equal key "=" on
> >> right-top keypad. In fact, this keyboard generate KEYPAD_XXX usage code
> >> for them, but I find many applications can not handle them on default
> >> configuration, especially X.org. To get the most best usability, I use a
> >> bit magic here: map them to "Shift+9" and "Shift+0".
> >>     
> >
> > That is hardly 'improvement'. 'X is broken, so lets break input, too'.
> >
> >
> >
> >   
> Well, however, this can work truly. If we do not hack as this way.
> Many applications can not get its input. I think the usability for
> most people should be first, but not follow rules.
>

I do not quite understand why X would have issues with it. KEY_KPEQUAL,
KEY_KPLEFTPAREN and KEY_KPRIGHTPAREN should work fine even with legacy
X keyboard driver (one that is using PS/2 protocol instead of evdev).
You might want to adjust your XKB map or use xmodmap, but kernel should
report true keycodes.
 
> I think we can add one module parameter like "shift_hack" to switch it ?!
> 

No please don't.

-- 
Dmitry
