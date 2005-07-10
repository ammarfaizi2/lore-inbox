Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVGJGhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVGJGhB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 02:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVGJGhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 02:37:00 -0400
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:47506 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261864AbVGJGg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 02:36:57 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Micheal Marineau <marineam@engr.orst.edu>
Subject: Re: ALPS psmouse_reset on reconnect confusing Tecra M2
Date: Sun, 10 Jul 2005 01:36:49 -0500
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <42C9A69A.5050905@waychison.com> <200507041705.17626.dtor_core@ameritech.net> <42CB63AD.4070208@engr.orst.edu>
In-Reply-To: <42CB63AD.4070208@engr.orst.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507100136.49735.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 July 2005 23:53, Micheal Marineau wrote:
> Dmitry Torokhov wrote:
> > On Monday 04 July 2005 16:14, Mike Waychison wrote:
> > 
> >>Hi,
> >>
> >>I just upgrade my Tecra M2 this weekend to the latest GIT tree and
> >>noticed that my mouse pointer/touchpad is now broken on resume.
> >>
> >>Investigating, it appears that mouse device gets confused due to the
> >>introduced psmouse_reset(psmouse) during reconnect:
> >>
> >>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f3a5c73d5ecb40909db662c4d2ace497b25c5940
> > 
> > 
> > Hi,
> > 
> > Please try the following patch:
> > 
> > 	http://www.ucw.cz/~vojtech/input/alps-suspend-typo
> >  
> 
> This fixed the problem for mylaptop, but ONLY if I had #define DEBUG in
> alps.c, switch it back to the usual #undef and the exact same problem
> happens.  I've got no idea what's going on, I'll poke at it more when
> I'm awake....
> 

Hi,

Sorry, any update on this topic? Does it still only work with DEBUG?

Thanks!

-- 
Dmitry
