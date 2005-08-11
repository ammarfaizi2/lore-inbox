Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVHKPbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVHKPbz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVHKPbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:31:55 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:8161
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S1751094AbVHKPby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:31:54 -0400
Date: Thu, 11 Aug 2005 17:30:56 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: hunold@linuxtv.org
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-dvb-maintainer@linuxtv.org
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
Message-ID: <20050811153056.GA26868@titan.lahn.de>
Mail-Followup-To: hunold@linuxtv.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-dvb-maintainer@linuxtv.org
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org> <20050811064217.GB21395@titan.lahn.de> <E1E3CJE-0001NJ-PH@allen.werkleitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E3CJE-0001NJ-PH@allen.werkleitz.de>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael!

On Thu, Aug 11, 2005 at 02:37:20PM +0200, hunold@linuxtv.org wrote:
> >I got the following OOPS from running "alevtd -F -d -v /dev/vbi0" with
> >my Siemens-DVB-C on a Dual-i686-600. I'm able to reproduce this even
> >running a 2.6.12-rc6 without the nvidia module tainting the kernel.
>
> So you're using the analog tuner of the card to watch analog cable tv and 
> want to decode teletext from the vbi, right? 

Yes.

> Can you tell me the last kernel version that worked for you? 

Sorry, it never worked before: After accessing /dev/vbi the computer
locked up after some time: no keyboard, only hard reset.
Might be related to that it is a dual P3-600.
I just tried it again yesterday to see if the situation with VBI
improved with the updated which went into 2.6.13-rc6 compared to the
situation half a year ago.

> >kernel BUG at drivers/media/common/saa7146_video.c:741!
> 
> 739         fmt = format_by_fourcc(dev,fh->video_fmt.pixelformat);
> 740         /* we need to have a valid format set here */
> 741         BUG_ON(NULL == fmt); 
> 
> This sanity check is failing. Apparently the software managed
> to select a pixelformat that cannot be translated to a "saa7146 format". 
> 
> Puh, I wrote this long ago. ;-) IIRC this should not be possible (ie. the 
> driver should reject the unknown pixelformat in the configuring stage). 

alevtd is outputting some debug information, which I'll capture for you.

> Did you update the alevt package? Perhaps it's now doing this differently 
> and it would fail with older kernels as well, which have worked before. 

alevtd is Debians 3.94-1

> We will probably have to debug this on a very low level.

Please feel free to contact my. Turn around might by long, since the PC
with DVB is at home without internet access, which I only have at work.

BYtE
Philipp

PS: Wir koennen auch Deutsch reden, nachdem wir die cc:-Liste reduziert
haben.
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
