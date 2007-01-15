Return-Path: <linux-kernel-owner+w=401wt.eu-S1750906AbXAOQDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbXAOQDh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 11:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbXAOQDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 11:03:36 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:39251 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1750900AbXAOQDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 11:03:36 -0500
Date: Mon, 15 Jan 2007 11:03:35 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: icxcnika@mar.tar.cc, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: usb somehow broken
In-Reply-To: <200701151210.49495.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0701151058520.15327-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007, Oliver Neukum wrote:

> Am Sonntag, 14. Januar 2007 20:47 schrieb icxcnika@mar.tar.cc:
> > > Can anyone suggest another approach?
> > >
> > > Alan Stern
> > 
> > Just a thought, you could use both a blacklist approach, and a module 
> > paramater, or something in sysfs, to allow specifying devices that won't 
> > be suspend and resume compatible.
> 
> Upon further thought, a module parameter won't do as the problem
> will arise without a driver loaded. A sysfs parameter turns the whole
> affair into a race condition. Will you set the guard parameter before the
> autosuspend logic strikes?
> Unfortunately this leaves only the least attractive solution.

There could be a mixed approach: a builtin blacklist that is extensible 
via a procfs- or sysfs-based interface.

Note that we actually have two problems to contend with.  Some devices
must never be autosuspended at all (they disconnect when resuming), and
others need a reset after resuming.

Alan Stern

