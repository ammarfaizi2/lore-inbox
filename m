Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTIPU7p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 16:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTIPU7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 16:59:45 -0400
Received: from gprs151-26.eurotel.cz ([160.218.151.26]:11395 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262494AbTIPU7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 16:59:44 -0400
Date: Tue, 16 Sep 2003 22:59:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add likely around access_ok for uaccess
Message-ID: <20030916205931.GF1205@elf.ucw.cz>
References: <3F644E36.5010402@colorfullife.com> <20030916194929.GF602@elf.ucw.cz> <20030916205545.GA14153@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916205545.GA14153@gtf.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > while trying to figure out why sysv msg is around 30% slower than pipes 
> > > for data transfers I noticed that gcc's autodetection (3.2.2) guesses 
> > > the "if(access_ok())" tests in uaccess.h wrong and puts the error memset 
> > > into the direct path and the copy out of line.
> > > 
> > > The attached patch adds likely to the tests - any objections? What about 
> > > the archs except i386?
> > 
> > How much speedup did you gain?
> 
> How much can it hurt?

The change is obviously okay, I just wanted to know... If it gains 30%
on sysv messages.. that would be pretty big surprise.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
