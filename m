Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVC2WkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVC2WkC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVC2Who
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:37:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11199 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261604AbVC2Wfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:35:38 -0500
Date: Wed, 30 Mar 2005 00:35:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: dtor_core@ameritech.net, Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Isaacson <adi@hexapodia.org>
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Message-ID: <20050329223519.GI8125@elf.ucw.cz>
References: <20050329181831.GB8125@elf.ucw.cz> <d120d50005032911114fd2ea32@mail.gmail.com> <20050329192339.GE8125@elf.ucw.cz> <d120d50005032912051fee6e91@mail.gmail.com> <20050329205225.GF8125@elf.ucw.cz> <d120d500050329130714e1daaf@mail.gmail.com> <20050329211239.GG8125@elf.ucw.cz> <d120d50005032913331be39802@mail.gmail.com> <20050329214408.GH8125@elf.ucw.cz> <1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We currently freeze processes for suspend-to-ram, too. I guess that
> > disable_usermodehelper is probably better and that in_suspend() should
> > only be used for sanity checks... go with disable_usermodehelper and
> > sorry for the noise.
> 
> Here's another possibility: Freeze the workqueue that
> call_usermodehelper uses (remember that code I didn't push hard enough
> to Andrew?), and let invocations of call_usermodehelper block in
> TASK_UNINTERRUPTIBLE. In refrigerating processes, don't choke on

There may be many devices in the system, and you are going to need
quite a lot of RAM for all that... That's why they do not queue it
during boot, IIRC. Disabling usermode helper seems right.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
