Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVBVXKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVBVXKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVBVXKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:10:39 -0500
Received: from waste.org ([216.27.176.166]:62912 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261336AbVBVXKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:10:15 -0500
Date: Tue, 22 Feb 2005 15:10:00 -0800
From: Matt Mackall <mpm@selenic.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OT: Why is usb data many times the cpu hog that firewire is?
Message-ID: <20050222231000.GA3163@waste.org>
References: <200502211216.35194.gene.heskett@verizon.net> <200502211325.55013.gene.heskett@verizon.net> <20050221182952.GF6722@wiggy.net> <200502211708.27211.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502211708.27211.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 05:08:27PM -0500, Gene Heskett wrote:
> On Monday 21 February 2005 13:29, Wichert Akkerman wrote:
> >Previously Gene Heskett wrote:
> >> Thats what I was afraid of, which makes using it for a motion
> >> detected burgular alarm source considerably less than practical
> >> since the machine must be able to do other things too.
> >
> >Dependin on the type of compression used you might be able to detect
> >motion by analyzing the compressed datastream.
> >
> Its jpg coming out of the camera, but I don't know to capture the raw 
> stream and do the comparisons.  One would have to first subtract the 
> expected peak values of the sensors noise (snow if you will), either 
> by a running average obtained by frame addition on a pixel by pixel 
> basis.  Somehow, that seems to imply a decoded stream.  And thats 
> obviously not going to be anything but cpu intensive too.  So I'm 
> less than enthusiastic that its a workable solution unless one is 
> able to dedicate a machine to that job exclusively.  X10 FIR's like 
> the EagleEye or HawkEye will need to be used to detect when the 
> recording should be started (and stopped)

JPEG data is DCT of 8x8 pixel chunks. If you can get at that, you can
compare the DC terms of each chunk with minimal decoding. Various
thumbnailers do this for speed already.

-- 
Mathematics is the supreme nostalgia of our time.
