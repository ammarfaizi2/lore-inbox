Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbTDXPLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 11:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbTDXPLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 11:11:12 -0400
Received: from pdbn-d9bb8734.pool.mediaWays.net ([217.187.135.52]:19722 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S262713AbTDXPLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 11:11:07 -0400
Date: Thu, 24 Apr 2003 17:23:03 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Werner Almesberger <wa@almesberger.net>
Cc: Pat Suwalski <pat@suwalski.net>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424152303.GA18573@citd.de>
References: <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net> <20030424134904.GA18149@citd.de> <3EA7EFF5.3060900@suwalski.net> <20030424143433.GA18374@citd.de> <20030424120403.N3557@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424120403.N3557@almesberger.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 12:04:03PM -0300, Werner Almesberger wrote:
> Matthias Schniedermeyer wrote:
> > Maybe it depends on hardware, or your mixer "transparently" unmutes the
> > channel when you increase volume.
> 
> Hmm, KMix doesn't do either, but if I mute the main volume and
> restart KMix, it will come up unmuted, but the volume set to
> zero.
> 
> Other mixers (XMixer, aumix) don't seem know of the concept of
> muting at all. (And switching input sources doesn't seem to
> have much effect on what gets sent to the speakers.)
> 
> Also, a quick grep through linux-*/sound/ doesn't find the
> word "mute". Are you sure this isn't a feature of the mixer
> instead of the sound API ?

man amixer
(the native ALSA-Mixer)

-- set --
       set or sset <SCONTROL> <PARAMETER> ...
              Sets the simple mixer control contents. The parameter can be the volume either as a percentage from 0% to 100% or an exact hardware  value.
              The  parameters cap, nocap, mute, unmute, toggle are used to change capture (recording) and muting for the group specified.  The parameters
              front, rear, center, woofer are used to specify channels to be changed. When plus(+) or minus(-) letter is appended after volume value, the
              volume is incremented or decremented from the current value, respectively.

              A simple mixer control must be specified. Only one device can be controlled at a time.
-- end --

-- example 1 --
              amixer -c 1 sset Line,0 80%,40% unmute cap
-- end --




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

