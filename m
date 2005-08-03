Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVHCLvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVHCLvc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVHCLtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:49:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:25262 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262229AbVHCLrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:47:36 -0400
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050802144516.GC2465@atrey.karlin.mff.cuni.cz>
References: <1122908972.18835.153.camel@gaston>
	 <20050802095312.GA1442@elf.ucw.cz>
	 <m1ack0xuzq.fsf@ebiederm.dsl.xmission.com>
	 <20050802144516.GC2465@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 13:43:27 +0200
Message-Id: <1123069408.30257.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 16:45 +0200, Pavel Machek wrote:
> Hi!
> 
> > >> Why are we calling driver suspend routines in these ? This is _not_
> > >
> > > Well, reason is that if you remove device_suspend() you'll get
> > > emergency hard disk park during powerdown. As harddrives can survive
> > > only limited number of emergency stops, that is not a good idea.
> > 
> > Then the practical question is: do we suspend the disk by
> > calling device_suspend() for every device.  Or do we modify
> > the ->shutdown() method for the disk.
> 
> The additional data in pm_message_t are usefull, and sharing code
> between suspend-to-ram and suspend-to-disk is usefull => option #1...

No.

Ben.


