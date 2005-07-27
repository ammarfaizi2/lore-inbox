Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVG0W6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVG0W6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVG0Wzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:55:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261216AbVG0Wyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:54:52 -0400
Date: Thu, 28 Jul 2005 00:54:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/23] reboot-fixes
Message-ID: <20050727225442.GD6529@elf.ucw.cz>
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com> <20050727025923.7baa38c9.akpm@osdl.org> <m1k6jc9sdr.fsf@ebiederm.dsl.xmission.com> <20050727104123.7938477a.akpm@osdl.org> <m18xzs9ktc.fsf@ebiederm.dsl.xmission.com> <20050727224711.GA6671@elf.ucw.cz> <20050727155118.6d67d48e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727155118.6d67d48e.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  > Good question.  I'm not certain if Pavel intended to add
> >  > device_suspend(PMSG_FREEZE) to the reboot path.  It was
> >  > there in only one instance.  Pavel comments talk only about
> >  > the suspend path.
> > 
> >  Yes, I think we should do device_suspend(PMSG_FREEZE) in reboot path.
> 
> Why?

Many bioses are broken; if you leave hardware active during reboot,
they'll hang during reboot. It is so common problem that I think that
only sane solution is make hardware quiet before reboot.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
