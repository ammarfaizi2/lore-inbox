Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUF3QLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUF3QLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbUF3QKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:10:49 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:18617 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S266753AbUF3QJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:09:35 -0400
Date: Wed, 30 Jun 2004 11:46:24 -0400
From: Ben Collins <bcollins@debian.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm4: regression: ieee1394: sbp2: null pointer dereference
Message-ID: <20040630154623.GB18174@phunnypharm.org>
References: <20040629181347.GA5259@kiste> <pan.2004.06.30.04.01.10.828506@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.06.30.04.01.10.828506@smurf.noris.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 06:01:10AM +0200, Matthias Urlichs wrote:
> Hi, Matthias Urlichs wrote:
> 
> > 2.6.7-mm4 oopses when confronted with an unresponsive iee1394 disk.
> 
> (Andrew helpfully forwarded this to 1394-dev. Thanks.)
> 
> Further tests show that the problem just shows up more reliably (if that's
> the word...) under -mm4. However, I just got the error on plain 2.6.7.

This oops traces back into the scsi stack, right? The spaghetti of
trying to get things to work right with the scsi stack is getting to be
a pain. I guess USB doesn't have too many problems since it does a
scsi-host per device, but that's not as easy with sbp2 and 1394, since a
single sbp2 device can have multiple LUN's, and it's just easier to
treat that as one scsi host.

I can't reproduce it, but I'll try to get into the logic of sbp2 device
removal again to see if I can find out where and why this is occuring.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
