Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUH1MIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUH1MIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 08:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUH1MIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 08:08:24 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:35460 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266488AbUH1MH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 08:07:59 -0400
Date: Sat, 28 Aug 2004 14:07:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: QuantumG <qg@biodome.org>
Cc: Craig Milo Rogers <rogers@isi.edu>, linux-kernel@vger.kernel.org
Subject: Re: reverse engineering pwcx
Message-ID: <20040828120759.GB1841@ucw.cz>
References: <412FD751.9070604@biodome.org> <20040828012055.GL24018@isi.edu> <20040828014931.GM24018@isi.edu> <412FF888.8090307@biodome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412FF888.8090307@biodome.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 01:14:16PM +1000, QuantumG wrote:

> Craig Milo Rogers wrote:
> 
> >	Hmmm... a poster on Slashdot claims that entropy measurements
> >imply that the pwcx code is interpolating rather that truly
> >decompressing.  Again, that's integer math and table lookups.
> 
> http://www.amazon.com/exec/obidos/tg/detail/-/B00005R098/102-7619892-0201738?v=glance
> 
> claims that the Logitech Quickcam Pro 3000 is a "True 640 x 480 
> resolution video capture" which is now clearly false.
> 
> It would appear I have found an answer to my question.  The reason 
> Philips made Nemosoft sign an NDA was not to hide proprietory 
> information from their competitors.  It was to hide the fact that they 
> were misrepresenting the resolution of their cameras to their 
> customers.  No wonder Nemosoft did not feel right about opening this 
> module even after the NDA expired, he would be telling the world their 
> dirty little secret.  Of course I'm sure this was common knowledge to 
> all those people who work in robotics and always demand an uncompressed 
> stream from the camera.

Well, it's definitely no surprise, you simply can't push the
uncompressed stream through USB1.1.

Us in robotics, we use the iBot2 from Orange Micro, which is an USB2.0
webcam working nicely with Linux at 30fps, 640x480, truecolor,
uncompressed.

So I don't think that Philips would really be able to "hide" this fact
by putting the decompressors into a binary only module - everybody knows
the compression must be lossy to allow for this high a compression
ratio.

Also, it's quite obvious that there is a big tradeoff between image
quality and algorithm complexity - it might be possible do do JPEG
compression in the webcam at full framerate and a reasonably low price,
but simpler algorithms with worse image quality still be well usable and
make the price even lower.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
