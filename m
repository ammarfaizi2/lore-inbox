Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbSKMALP>; Tue, 12 Nov 2002 19:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbSKMALP>; Tue, 12 Nov 2002 19:11:15 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:35240 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266995AbSKMALO>; Tue, 12 Nov 2002 19:11:14 -0500
Subject: Re: i810 audio
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Kundrat <kundrat@kundrat.sk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021113000449.GB7015@napri.sk>
References: <Pine.LNX.4.44.0211121802540.27793-100000@graze.net>
	<1037144284.10029.0.camel@irongate.swansea.linux.org.uk>
	<20021112184349.A11757@redhat.com>  <20021113000449.GB7015@napri.sk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 00:43:19 +0000
Message-Id: <1037148199.10029.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 00:04, Peter Kundrat wrote:
> On Tue, Nov 12, 2002 at 06:43:49PM -0500, Doug Ledford wrote:
> > And in some implementations the codec control labelled PCM2 is actually 
> > main volume, and I've seen one where a headphone was the actual main 
> > volume.  So, the answer is tinker with all the available volume sliders to 
> > see if you can find one that actually changes the volume of everything at 
> > once, and if you do find it, use it.
> 
> Isnt there a way for userspace to somehow find this? It is a bit
> annoying that main volume control in kmix doesnt work (and thus the one
> in panel; also there is no headphone control there).
> The other option would be to configure userspace which control is the
> main one (but windows doesnt need that, so this solution would be
> inferior). Eventually i will take a look what does the win driver (maybe
> it sets main and headphone control always together). Until then i'd like
> to hear what are our options .. since the current situation is not
> really desirable.

The kernel knows which AC'97 chip is attached so it could be given a
table to specify chips where "volume" should either not be presented or
should be remapped. Do you know what AC97 chip is on your board (Linux
will print the info in the i810 load, windows and the manual probably
claim that you have that as your sound chip (typically "Analog
something" or "Crystal something").


