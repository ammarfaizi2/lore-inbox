Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVHBOsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVHBOsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVHBOqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:46:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63920 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261546AbVHBOpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:45:23 -0400
Date: Tue, 2 Aug 2005 16:45:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
Message-ID: <20050802144516.GC2465@atrey.karlin.mff.cuni.cz>
References: <1122908972.18835.153.camel@gaston> <20050802095312.GA1442@elf.ucw.cz> <m1ack0xuzq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ack0xuzq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Why are we calling driver suspend routines in these ? This is _not_
> >
> > Well, reason is that if you remove device_suspend() you'll get
> > emergency hard disk park during powerdown. As harddrives can survive
> > only limited number of emergency stops, that is not a good idea.
> 
> Then the practical question is: do we suspend the disk by
> calling device_suspend() for every device.  Or do we modify
> the ->shutdown() method for the disk.

The additional data in pm_message_t are usefull, and sharing code
between suspend-to-ram and suspend-to-disk is usefull => option #1...

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
