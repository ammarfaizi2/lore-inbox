Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWJHO13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWJHO13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWJHO13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:27:29 -0400
Received: from mx2.rowland.org ([192.131.102.7]:39694 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1751191AbWJHO13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:27:29 -0400
Date: Sun, 8 Oct 2006 10:27:27 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] error to be returned while suspended
In-Reply-To: <200610080907.16443.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0610081021520.17010-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Oct 2006, Oliver Neukum wrote:

> I've never said that autosuspend is a bad idea. For many devices it is
> simple and painless. But it is insufficient. Therefore I think removing
> the ability to explicitely request a suspension from user space is wrong.

I tend to agree.  And I expect we _will_ end up with a userspace interface 
for suspending some devices.  Other devices, like USB hubs, have no need 
of such an interface (other than for testing, perhaps).

The reason for removing the current interface is just that it is so bad.  
Look how confused you were when you saw it recently.  Values are 0, 2, and
3, 3 automatically gets changed to 2,...  There isn't even any way for a
driver to tell whether a suspend message is a runtime request from
userspace or a system sleep transition notification!

> If so many people cannot come up with a good design, doesn't that indicate
> there's no single method that satisfies all needs?

Probably.  That's why I've been saying all along that these things need to 
be decided by the individual drivers.  No single design will be 
appropriate for all of them.

Alan Stern

