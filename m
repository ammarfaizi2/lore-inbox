Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261831AbSJNFiR>; Mon, 14 Oct 2002 01:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSJNFiQ>; Mon, 14 Oct 2002 01:38:16 -0400
Received: from bgp01116664bgs.westln01.mi.comcast.net ([68.42.104.18]:57938
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id <S261831AbSJNFiP>; Mon, 14 Oct 2002 01:38:15 -0400
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not
	suspend devices
From: Eric Blade <eblade@blackmagik.dynup.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m1of9xlw7g.fsf@frodo.biederman.org>
References: <200210132359.QAA01092@adam.yggdrasil.com> 
	<m1of9xlw7g.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 14 Oct 2002 01:38:45 -0400
Message-Id: <1034573925.2786.55.camel@cpq>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is where I realize that I've forgotten to CC: the list on all the
traffic that I keep sending between Eric and Adam.  D'oh.


On Sun, 2002-10-13 at 20:07, Eric W. Biederman wrote:
> > 
> > 	However, I'm not trying to quash what you want to discuss.
> > I'd be interested in hearing about clarifications and perhaps
> > extensions of the struct device_driver methods, which I think is what
> > you're getting at, perhaps here or on linux-hotplug.  It's just that,
> > for this thread, I'm trying to focus on my patch that eliminates the
> > software suspend on reboot (pros and cons, alternatives to it, etc.).
> 
> The 2.5.41 variant is below.  The bug is reusing the old enumeration value
> as was previously mentioned.
> 

I tried to submit a fix to this, but the only response I've gotten back
is that it failed to apply.  My original patch excluded the bit from
device.h that added a new state to the enumeration, and when it got into
the tree, it got into the tree using the current states that were
available.  My bad.  

Eric has already indicated earlier, that Adam's issue is, however, not
with the changes to drivers/base/power.c but to the changes to the IDE
driver.  

 - Eric



