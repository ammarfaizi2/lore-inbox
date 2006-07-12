Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWGLQ4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWGLQ4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWGLQ4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:56:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4546 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751256AbWGLQ4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:56:52 -0400
Date: Wed, 12 Jul 2006 12:56:48 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: annoying frequent overcurrent messages.
Message-ID: <20060712165648.GA14453@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>
References: <200607111747.13529.david-b@pacbell.net> <Pine.LNX.4.44L0.0607121012570.6607-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0607121012570.6607-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 10:19:39AM -0400, Alan Stern wrote:
 > Dave Jones wrote:
 > 
 > > I have a box that's having its dmesg flooded with..
 > > 
 > > hub 1-0:1.0: over-current change on port 1
 > > hub 1-0:1.0: over-current change on port 2
 > > hub 1-0:1.0: over-current change on port 1
 > > hub 1-0:1.0: over-current change on port 2
 > ...
 > 
 > > over and over again..
 > > The thing is, this box doesn't even have any USB devices connected to it,
 > > so there's absolutely nothing I can do to remedy this.
 > 
 > Well, overcurrent is a potentially dangerous situation.  That's why it 
 > gets reported with dev_err priority.
 > 
 > Evidently it's a hardware fault.  Perhaps the overcurrent-detect input 
 > lines are floating and constantly triggering as a result.  It's not even 
 > clear that attaching a USB device would make the problem go away.
 > 
 > Since you're not using the UHCI controller on that computer, you could 
 > simply rmmod uhci-hcd (or modify /etc/modprobe.conf to prevent it from 
 > being loaded in the first place).  That would stop the constant interrupts 
 > and the syslog spamming.
 > 
 > But as for fixing the underlying hardware problem, I don't think there's 
 > anything we can do.

we could at least rate-limit the messages.

		Dave

-- 
http://www.codemonkey.org.uk
