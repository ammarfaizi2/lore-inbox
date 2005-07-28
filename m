Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVG1Hod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVG1Hod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVG1Hoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:44:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21415 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261337AbVG1Hnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:43:51 -0400
Date: Thu, 28 Jul 2005 09:43:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
Message-ID: <20050728074344.GH6529@elf.ucw.cz>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com> <20050727025923.7baa38c9.akpm@osdl.org> <m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com> <20050727104123.7938477a.akpm@osdl.org> <m18xzs9ktc.fsf@ebiederm.dsl.xmission.com> <20050727224711.GA6671@elf.ucw.cz> <Pine.LNX.4.58.0507271550250.3227@g5.osdl.org> <20050727225334.GC6529@elf.ucw.cz> <m1oe8n7s4v.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1oe8n7s4v.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > Yes, I think we should do device_suspend(PMSG_FREEZE) in reboot path.
> >> 
> >> Considering how many device drivers that are likely broken, I disagree. 
> >> Especially since Andrew seems to have trivially found a machine where it 
> >> doesn't work.
> >
> > I'm not sure if we want to do that for 2.6.13, but long term, we
> > should just tell drivers to FREEZE instead of inventing reboot
> > notifier lists and similar uglynesses...
> 
> Then as part of the patch device_shutdown should disappear.  It
> is silly to have two functions that want to achieve the same
> thing.  

I always thought that device_shutdown is different phase -- the one
with interrupts disabled...
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
