Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264023AbUKZV7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbUKZV7v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbUKZV5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:57:05 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:12725 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263969AbUKZVzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 16:55:09 -0500
Subject: Re: Suspend 2 merge: 43/51: Utility functions.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>, Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125234635.GF2909@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101299832.5805.371.camel@desktop.cunninghams>
	 <20041125234635.GF2909@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101427475.27250.170.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 11:04:35 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 10:46, Pavel Machek wrote:
> Hi!
> 
> > These are the routines that I think could possibly be useful elsewhere
> > too.
> > 
> > - A snprintf routine that returns the number of bytes actually put into
> > the buffer, not the number that would have been put in if the buffer was
> > big enough.
> > - Routine for finding a proc dir entry (we use it to find /proc/splash
> > when)
> > - Support routines for dynamically allocated pageflags. Save those
> > precious bits!
> 
> How many bits do you need? Two? I'd rather use thow two bits than have
> yet another abstraction. Also note that it is doing big order
> allocation.

Three if checksumming is enabled IIRC. I'll happily use normal page
flags, but we only need them when suspending, and I understood they were
rarer than hen's teeth :>

MM guys copied so they can tell me I'm wrong :>

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

