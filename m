Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbUCHSeU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 13:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbUCHSeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 13:34:20 -0500
Received: from gprs40-150.eurotel.cz ([160.218.40.150]:13678 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261644AbUCHSeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 13:34:18 -0500
Date: Mon, 8 Mar 2004 19:34:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Some highmem pages still in use after shrink_all_memory()?
Message-ID: <20040308183401.GE484@elf.ucw.cz>
References: <20040307144921.GA189@elf.ucw.cz> <20040307164052.0c8a212b.akpm@osdl.org> <20040308063639.GA20793@hexapodia.org> <1078738772.4678.5.camel@laptop.fenrus.com> <20040308163611.GA8219@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308163611.GA8219@hexapodia.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Note that there are some applications for which it is a *bug* if an
> > > mlocked page gets written out to magnetic media.  (gpg, for example.)
> > 
> > mlock() does not guarantee things not hitting magnetic media, just as
> > mlock() doesn't guarantee that the physical address of a page doesn't
> > change. mlock guarantees that you won't get hard pagefaults and that you
> > have guaranteed memory for the task at hand (eg for realtime apps and
> > oom-critical stuff)
> 
> Well, that's fine -- you can certainly define mlock to have whatever
> semantics you want.  But the semantics that gpg depends on are
> reasonable, and if mlock is changed to have other semantics, there
> should be some way for apps to get the behavior that used to be
> implemented by mlock (and *documented* in the mlock man page).
> 
> It's a pity that mlock doesn't take a flags argument.

How would it help?

Block system-wide suspend because 4K are mlocked?
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
