Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTL0NEy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 08:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTL0NEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 08:04:54 -0500
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:61830
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S264396AbTL0NEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 08:04:53 -0500
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
From: Edward Tandi <ed@efix.biz>
To: azarah@nosferatu.za.org
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, perex@suse.cz,
       alsa-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rob Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       Stan Bubrouski <stan@ccs.neu.edu>
In-Reply-To: <1072527874.12308.100.camel@nosferatu.lan>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>
	 <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]>
	 <1072500516.12203.2.camel@duergar>  <8240000.1072511437@[10.10.2.4]>
	 <1072523478.12308.52.camel@nosferatu.lan>
	 <1072525450.3794.8.camel@wires.home.biz>
	 <1072527874.12308.100.camel@nosferatu.lan>
Content-Type: text/plain
Message-Id: <1072530488.2906.1.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2mdk 
Date: Sat, 27 Dec 2003 13:08:08 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-27 at 12:24, Martin Schlemmer wrote:
> On Sat, 2003-12-27 at 13:44, Edward Tandi wrote:
> > On Sat, 2003-12-27 at 11:11, Martin Schlemmer wrote:
> > > On Sat, 2003-12-27 at 09:50, Martin J. Bligh wrote:
> > > > Something appears to have broken OSS sound emulation between 
> > > > test2 and test3. Best I can tell (despite the appearance of the BK logs), 
> > > > that included ALSA updates 0.9.5 and 0.9.6. Hopefully someone who
> > > > understands the sound architecture better than I can fix this?
> > > > 
> > > 
> > > I wont say I understand it, but a quick look seems the major change is
> > > the addition of the 'whole-frag' and 'no-silence' opts.  You might try
> > > the following to revert what 'no-silence' change at least does:
> > > 
> > > --
> > >  # echo 'xmms 0 0 no-silence' > /proc/asound/card0/pcm0p/oss
> > >  # echo 'xmms 0 0 whole-frag' > /proc/asound/card0/pcm0p/oss
> > > --
> > 
> > Thanks, that fixes it for me. I too have been seeing terrible problems
> > with XMMS since the early 2.6 pre- kernels.
> > 
> > Because it only happens in XMMS I thought it was one of those
> > application bugs brought out by scheduler changes. I now use Zinf BTW
> > -It's better for large music collections (although not as stable or
> > flash).
> > 
> 
> Can you check which one actually fixes it ?

Yes, its the 'whole-frag' line.

Ed-T.


