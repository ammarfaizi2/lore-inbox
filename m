Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422916AbWBIRHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422916AbWBIRHk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422917AbWBIRHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:07:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40715 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965239AbWBIRGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:06:51 -0500
Date: Wed, 8 Feb 2006 21:54:13 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: swsusp done by migration (was Re: [RFC][PATCH 1/5] Virtualization/containers: startup)
Message-ID: <20060208215412.GD2353@ucw.cz>
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru> <m1hd7condi.fsf@ebiederm.dsl.xmission.com> <1139243874.6189.71.camel@localhost.localdomain> <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Could you explain a bit why the container ID would need to be
> > virtualized?
> 
> As someone said to me a little bit ago, for migration or checkpointing
> ultimately you have to capture the entire user/kernel interface if
> things are going to work properly.  Now if we add this facility to
> the kernel and it is a general purpose facility.  It is only a matter
> of time before we need to deal with nested containers.
> 
> Not considering the case of having nested containers now is just foolish.
> Maybe we don't have to implement it yet but not considering it is silly.
> 
> As far as I can tell there is a very reasonable chance that when we
> are complete there is a very reasonable chance that software suspend
> will just be a special case of migration, done complete in user space.
> That is one of the more practical examples I can think of where this
> kind of functionality would be used.

Well, for now software suspend is done at very different level
(it snapshots complete kernel state), but being able to use
migration for this is certainly nice option.

BTW you could do whole-machine-migration now with uswsusp; but you'd
need identical hardware and it would take a bit long... 

							Pavel
-- 
Thanks, Sharp!
