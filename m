Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269728AbUJMO3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269728AbUJMO3n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269727AbUJMO3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:29:43 -0400
Received: from ida.rowland.org ([192.131.102.52]:6660 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S269728AbUJMO3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:29:19 -0400
Date: Wed, 13 Oct 2004 10:29:18 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Mackerras <paulus@samba.org>
cc: Patrick Mochel <mochel@digitalimplant.org>,
       David Brownell <david-b@pacbell.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Proposed fix for PM deadlock on dpm_sem
In-Reply-To: <200410121625.13431.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0410131024370.1181-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004, Paul Mackerras wrote:

> I have been having trouble with deadlocks on dpm_sem when suspending
> and resuming, particularly if I remove a usb device while my powerbook
> is suspended.  The dpm_sem deadlocks also mean that USB can't deal
> with devices whose drivers don't have suspend/resume callbacks by
> simply disconnecting the device, as it did in the past.  This meant
> that while I can get my dual G4 powermac desktop machine to suspend
> to ram and resume (using the powerbook sleep code), its USB keyboard
> wouldn't work after resume.

A while ago I posted some thoughts on locking in the driver model which 
are somewhat relevant here.  Please take a look at

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=109596905805858&w=2

It doesn't address exactly the same issues you're concerned with, but it
does concern the way suspend/resume interacts with device
addition/removal.

Alan Stern

