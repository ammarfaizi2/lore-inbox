Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbTAYVAD>; Sat, 25 Jan 2003 16:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTAYVAD>; Sat, 25 Jan 2003 16:00:03 -0500
Received: from adsl-17-210-74.mia.bellsouth.net ([68.17.210.74]:36177 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S262208AbTAYVAC>;
	Sat, 25 Jan 2003 16:00:02 -0500
Date: Sat, 25 Jan 2003 16:28:11 -0500
To: pharao90@tzi.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mozilla stalls in 2.4.21-pre3
Message-ID: <20030125212811.GA30251@lnuxlab.ath.cx>
References: <20030125193013$7145@gated-at.bofh.it> <E18cX1P-0000iI-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18cX1P-0000iI-00@neptune.local>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2003 at 09:35:23PM +0100, Pascal Schmidt wrote:
> On Sat, 25 Jan 2003 20:30:13 +0100, you wrote in linux.kernel:
> 
> > When playing an mp3 with xmms and using mozilla, sometimes when I click
> > on a link, mozilla stalls.  When I stop the mp3, the page finally loads.
> > Let me know if you need any more information. TIA.
> > 
> > My kernel is 2.4.21-pre3.
> > 
> > My soundcard uses es1371.
> 
> The es1371 driver only provides one digital playback channel. So, if one
> application uses /dev/dsp, other applications trying to do the same will
> block.
> 
> Most likely, the web page you're trying to open has some flash animation
> on it (even some ad banners use flash) and the flashplayer plugin tries
> to open /dev/dsp and blocks, and since mozilla waits for the plugin
> to initialize, it blocks, too.

Once I stop the mp3 to let the page load, I can start the mp3 again,
reload the page, and it works..

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
