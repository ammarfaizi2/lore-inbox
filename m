Return-Path: <linux-kernel-owner+w=401wt.eu-S932673AbXAHVEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbXAHVEb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbXAHVEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:04:30 -0500
Received: from eazy.amigager.de ([213.239.192.238]:55275 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932673AbXAHVEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:04:30 -0500
Date: Mon, 8 Jan 2007 22:04:28 +0100
From: Tino Keitel <tino.keitel@tikei.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3 regression: suspend to RAM broken on Mac mini Core Duo
Message-ID: <20070108210428.GA7199@dose.home.local>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20070107151744.GA9799@dose.home.local> <1168194194.18788.63.camel@mindpipe> <20070107200453.GA3227@thinkpad.home.local> <20070107222706.GA6092@thinkpad.home.local> <20070107234445.GM20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107234445.GM20714@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 00:44:45 +0100, Adrian Bunk wrote:
> On Sun, Jan 07, 2007 at 11:27:06PM +0100, Tino Keitel wrote:
> > On Sun, Jan 07, 2007 at 21:04:53 +0100, Tino Keitel wrote:
> > > On Sun, Jan 07, 2007 at 13:23:13 -0500, Lee Revell wrote:
> > > > On Sun, 2007-01-07 at 16:17 +0100, Tino Keitel wrote:
> > > > > No information about the device/driver that refuses to resume.
> > > > 
> > > > You should be able to identify the problematic driver by removing each
> > > > driver manually before suspending.
> > > 
> > > I can not reproduce it anymore, resume now works. I really hope that it
> > > will stay so.
> > 
> > It didn't. It looks like it is unusable, becuase it isn't reliable in
> > 2.6.20-rc3.
> 
> Is this issue still present in -rc4?

I used 2.6.20-rc4 in single user mode, and applied 2 patches from
netdev to get wake on LAN support. This way I was able to set up an
automatic suspend/resume loop. It looked good, but after e.g. 20
minutes, the resume hang. So it is reproduceable with 2.6.20-rc4.
Unfortunately, I can not test the same with 2.6.18, as the wake on LAN
patches need 2.6.20-rc.

Regards,
Tino
