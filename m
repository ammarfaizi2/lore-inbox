Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTFIVvb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTFIVvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:51:31 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:30385 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262164AbTFIVva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:51:30 -0400
Date: Tue, 10 Jun 2003 00:04:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
Message-ID: <20030609220442.GD508@elf.ucw.cz>
References: <20030609212348.GB508@elf.ucw.cz> <Pine.LNX.4.44.0306091428470.11379-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306091428470.11379-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, can you be a little more concrete? I do not see any description
> > about what is system device and what is not.
> > 
> > Keyboard controller is very deeply integrated into the system. If it
> > is not system device, what is it?
> 
> I apologize that the description of system devices is not in the driver 
> model documentation. From the linux.conf.au paper:
> 
> System-level devices are devices that are integral to the routine
> operation of the system. This includes devices such as processors,
> interrupt controllers, and system timers. System devices do not follow
> normal read/write semantics. Because of this, they are not typically
> regarded as I/O devices, and are not represented in any standard
> way. 

What about mtrr's? They seem like system-level devices to me. Still
its usefull to have kmalloc in its suspend routine, which moves it to
SAVE_STATE phase.

Decision on which level to put it is up to programmer, and it seems
wrong to hardcode it into architecture. It may be more convient to do
save stating at place where you still can kmalloc...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

