Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266158AbUGZXLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266158AbUGZXLp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUGZXLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:11:45 -0400
Received: from sol.linkinnovations.com ([203.94.173.142]:18048 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S266158AbUGZXCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:02:38 -0400
Date: Tue, 27 Jul 2004 09:01:16 +1000
From: CaT <cat@zip.com.au>
To: Ed Sweetman <safemode@comcast.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, Jim Gifford <maillist@jg555.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Future devfs plans
Message-ID: <20040726230116.GA6339@zip.com.au>
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com> <057601c472a3$9df39ac0$d100a8c0@W2RZ8L4S02> <41044DA6.5080501@comcast.net> <20040726180901.GG11817@fs.tum.de> <41057B58.1040808@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41057B58.1040808@comcast.net>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 05:44:56PM -0400, Ed Sweetman wrote:
> Adrian Bunk wrote:
> > apt-get install alsa-base
> >
> >Check
> >
> > /var/lib/dpkg/info/alsa-base.postinst
> >
> >and (surprise, surprise!), you'll note the snddevices script is executed 
> >when installing the alsa-base package.
>
> And someone who compiles the kernel for themselves and never needs the 

Like I.

> alsa-base deb wouldn't have any ability to create the devices.  MAKEDEV 

alsa-base doesn't supply any modules:

# apt-file list alsa-base
alsa-base: etc/apm/event.d/alsa
alsa-base: etc/devfs/conf.d/alsa
alsa-base: etc/init.d/alsa
alsa-base: usr/share/alsa-base/alsa-base.conf
alsa-base: usr/share/alsa-base/modules-snippet.conf
alsa-base: usr/share/alsa-base/program-wrapper
alsa-base: usr/share/alsa-base/snddevices
alsa-base: usr/share/doc/alsa-base/FAQ
alsa-base: usr/share/doc/alsa-base/NEWS.Debian.gz
alsa-base: usr/share/doc/alsa-base/README
alsa-base: usr/share/doc/alsa-base/README.Debian
alsa-base: usr/share/doc/alsa-base/SOUNDCARDS.gz
alsa-base: usr/share/doc/alsa-base/WARNING
alsa-base: usr/share/doc/alsa-base/changelog.Debian.gz
alsa-base: usr/share/doc/alsa-base/copyright
alsa-base: usr/share/doc/alsa-base/examples/modules-1.0.conf
alsa-base: usr/share/linda/overrides/alsa-base
alsa-base: usr/share/lintian/overrides/alsa-base

And the init.d script doesn't do any loading of modules. It saves and
restores the mixer settings.

> is the proper place to create devices, not a separate snddevices 
> script.  This is still a debian bug.

Correct, for any version of debian where the supplied kernel is >= 2.6
I'd say.

-- 
    Red herrings strewn hither and yon.
