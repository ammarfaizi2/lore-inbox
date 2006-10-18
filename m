Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161178AbWJRPxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161178AbWJRPxB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbWJRPxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:53:00 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51214 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161178AbWJRPw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:52:59 -0400
Date: Wed, 18 Oct 2006 11:52:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Matthew Wilcox <matthew@wil.cx>
cc: Brian King <brking@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, Adam Belay <abelay@MIT.EDU>
Subject: Re: [linux-pm] [PATCH] Block on access to temporarily unavailable
 pci device
In-Reply-To: <20061018145141.GO22289@parisc-linux.org>
Message-ID: <Pine.LNX.4.44L0.0610181151450.6766-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006, Matthew Wilcox wrote:

> On Wed, Oct 18, 2006 at 10:38:20AM -0400, Alan Stern wrote:
> > You have to do _something_, because a user task could be about to read the
> > configuration space at the exact moment you want to start the BIST.  That
> > means ipr would have to wait until the user access is finished, which
> > means it has to be prepared to sleep one way or another.
> 
> Actually, it only has to spin until the user has finished accessing
> config space.  See the patch I just posted.

I stand corrected.

Don't you want the user process to wait in TASK_INTERRUPTIBLE?  It would 
require only a very simple change.

Alan Stern

