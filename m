Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267269AbUGNMNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267269AbUGNMNo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUGNMNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:13:44 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:35210 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S267269AbUGNMNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:13:40 -0400
Date: Wed, 14 Jul 2004 07:33:04 -0400
From: Ben Collins <bcollins@debian.org>
To: Hugang <hugang@soulinfo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix rmmod sbp2 hang in 2.6.7
Message-ID: <20040714113304.GB30536@phunnypharm.org>
References: <20040714114854.29d4e015@localhost> <20040714161357.426b5c08@localhost> <20040714171107.49aa64f7@localhost> <20040714102417.A12942@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714102417.A12942@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 10:24:17AM +0100, Russell King wrote:
> On Wed, Jul 14, 2004 at 05:11:07PM +0800, Hugang wrote:
> > On Wed, 14 Jul 2004 16:13:57 +0800
> > Hugang <hugang@soulinfo.com> wrote:
> > | On Wed, 14 Jul 2004 11:48:54 +0800
> > | Hugang <hugang@soulinfo.com> wrote:
> > | 
> > ....
> > | Sorry, the above patch, can't fix rmmod sbp2 complete,I still got hang when
> > | rmmod sbp2 in my PowerBook G4 sometimes.
> > | 
> > 
> > This new patch can complete fix the bug. That's really hack. Any comment are
> > welcome.
> 
> This down+up prevents drivers from being unloaded until there are no
> references to their struct device_driver.  By removing this, you open
> the very real possibility for an oops to occur.
> 
> If you're waiting inside that function for the last reference to be
> dropped, the real question is why you still have references to it.

Seems like every 2 months or so I have to revisit the sbp2 module to see
where the scsi layer has changed (or the driver model) so that I can get
all the reference counting to equal out properly. Guess it's been two
months again :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
