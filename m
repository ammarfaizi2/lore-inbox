Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266498AbUH1MXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUH1MXc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 08:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUH1MXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 08:23:32 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:41348 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266498AbUH1MX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 08:23:29 -0400
Date: Sat, 28 Aug 2004 14:23:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Craig Milo Rogers <rogers@isi.edu>, QuantumG <qg@biodome.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reverse engineering pwcx
Message-ID: <20040828122333.GC1841@ucw.cz>
References: <412FD751.9070604@biodome.org> <20040828012055.GL24018@isi.edu> <20040828014931.GM24018@isi.edu> <412FF888.8090307@biodome.org> <20040828033552.GN24018@isi.edu> <1093664940.8611.8.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093664940.8611.8.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 11:49:00PM -0400, Lee Revell wrote:
> On Fri, 2004-08-27 at 23:35, Craig Milo Rogers wrote:
> > On 04.08.28, QuantumG wrote:
> > > Craig Milo Rogers wrote:
> > > 
> > > >	Hmmm... a poster on Slashdot claims that entropy measurements
> > > >imply that the pwcx code is interpolating rather that truly
> > > >decompressing.  Again, that's integer math and table lookups.
> > > > 
> > > >
> > > 
> > > http://www.amazon.com/exec/obidos/tg/detail/-/B00005R098/102-7619892-0201738?v=glance
> > > 
> > > claims that the Logitech Quickcam Pro 3000 is a "True 640 x 480 
> > > resolution video capture" which is now clearly false.
> > 
> > 	If the "now clearly false" is meant to be a consequence of the
> > entropy measurements poster I referred to, I wouldn't jump the gun.
> > On reflection, it's entirely natural for a decompressed stream to
> > examine less entropy than the corresponding compressed stream!
> > 
> 
> Please see this slashdot thread:
> 
> http://linux.slashdot.org/comments.pl?sid=119578&threshold=3&mode=flat&commentsort=0&op=Change
> 
> The LavaRnd guys examined the pixels on the actual CCD chip.  It's
> 160x120.  The 'decompression' is just interpolation.

It's hard to believe this. I'd believe it if there was supposed to be a
320x240 chip (or even more probably 384x288 (QCIF)), as those are rather
common and with proper scaling up from the Bayer RGB pattern you can do
a rather good interpolation to 640x480 or 768x576.

But 160x120 sounds pretty ridiculous. It still would be possible to
scale that to 640x480 smoothly, but the image would be obviously blurry
and just awful even with avanced Bayer-based scaling techniques.

If Philips really does that, and succeeds, then I see the reason to
protect those methods, as it would allow the competition with better
sensors to scale to even higher resolutions (heh, my iBot2 webcam would
then be a 2560x1920 camera - that's 5 megapixels!).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
