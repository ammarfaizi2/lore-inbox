Return-Path: <linux-kernel-owner+w=401wt.eu-S1750905AbXAOQYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbXAOQYw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 11:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbXAOQYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 11:24:52 -0500
Received: from mail.suse.de ([195.135.220.2]:45182 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbXAOQYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 11:24:52 -0500
From: Oliver Neukum <oneukum@suse.de>
Organization: Novell
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.20-rc4: usb somehow broken
Date: Mon, 15 Jan 2007 17:24:42 +0100
User-Agent: KMail/1.9.1
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       icxcnika@mar.tar.cc, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0701151058520.15327-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0701151058520.15327-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701151724.42831.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. Januar 2007 17:03 schrieb Alan Stern:
> On Mon, 15 Jan 2007, Oliver Neukum wrote:

> > Upon further thought, a module parameter won't do as the problem
> > will arise without a driver loaded. A sysfs parameter turns the whole
> > affair into a race condition. Will you set the guard parameter before the
> > autosuspend logic strikes?
> > Unfortunately this leaves only the least attractive solution.
> 
> There could be a mixed approach: a builtin blacklist that is extensible 
> via a procfs- or sysfs-based interface.

If you want to ask with a lot of bug reports which blacklist was loaded,
then we could.
 
> Note that we actually have two problems to contend with.  Some devices
> must never be autosuspended at all (they disconnect when resuming), and
> others need a reset after resuming.

Do those who can be brought back with a reset need to be listed at all?
Error handling is not a bad idea.

	Regards
		Oliver
