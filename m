Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWAUDwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWAUDwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 22:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWAUDwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 22:52:54 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:26242 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932272AbWAUDwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 22:52:53 -0500
Subject: Re: [Alsa-devel] Re: RFC: OSS driver removal, a slightly different
	approach
From: Lee Revell <rlrevell@joe-job.com>
To: Dag Nygren <dag@newtech.fi>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       perex@suse.cz
In-Reply-To: <20060120082155.24254.qmail@dag.newtech.fi>
References: <20060120082155.24254.qmail@dag.newtech.fi>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 22:52:50 -0500
Message-Id: <1137815571.3241.133.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 10:21 +0200, Dag Nygren wrote:
> > On Thu, 2006-01-19 at 21:24 +0100, Krzysztof Halasa wrote:
> > > Don't you all think a large part (if not most) of the
> > > "ALSA-unsupported"
> > > cards is no longed in any (Linux-related) use? I wouldn't be surprised
> > > if they just don't exist anymore. Who is to write drivers for them and
> > > -
> > > more importantly - who can test them? 
> > 
> > Yes, it would require a collector of ancient sound hardware... do you
> > know anyone like that?
> > 
> > Even the NeoMagic 256 which is a Pentium II era device and was in
> > widespread use we cannot find a tester for.
> 
> I could do that, my boy is still playing tuxpaint and other stuff on my old 
> laptop
> with such a chip.

Thanks!

Basically just see if you can produce a hang by repeatedly loading and
unloading snd-nm256, preferably at a console, so you can see any Oops.
If you do see the hang, try the reset_workaround options described in
ALSA-Configuration.txt.

If you can reproduce a hang add printks in the module __init code and
try to narrow down where it dies.

Lee

