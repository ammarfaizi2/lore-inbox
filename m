Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbTIUUm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 16:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbTIUUm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 16:42:57 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:51630 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262588AbTIUUm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 16:42:56 -0400
Date: Sun, 21 Sep 2003 22:42:37 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Broken synaptics mouse..
Message-ID: <20030921204237.GA25441@ucw.cz>
References: <Pine.LNX.4.44.0309110744030.28410-100000@home.osdl.org> <Pine.LNX.4.44.0309190129170.32637-100000@telia.com> <20030919114806.GD784@ucw.cz> <m2fziqukhi.fsf@p4.localdomain> <20030921172758.GA21014@ucw.cz> <m2u176rldl.fsf@p4.localdomain> <20030921193400.GA22743@ucw.cz> <m2pthtriqe.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2pthtriqe.fsf@p4.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 10:26:17PM +0200, Peter Osterlund wrote:
> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > On Sun, Sep 21, 2003 at 09:29:10PM +0200, Peter Osterlund wrote:
> > 
> > > One thing that it doesn't get right is the handling of invalid ABS_*
> > > values. How is this supposed to be handled? The driver doesn't know
> > > the exact limits for the X/Y values, and discarding values outside
> > > some guessed limits will only have the effect that some parts of the
> > > touchpad area becomes dead.
> > 
> > I think something like 'if the finger is lifted so much above surface
> > that X and Y are unreliable, don't report X and Y'. Is that doable?
> 
> Yes, it should be sufficient to only report X/Y when Z>0. (I thought
> invalid values referred to all values outside the limits defined by
> dev->absmin and absmax, hence my previous comment.)
> 
> Here is a new patch:
> 
>  linux-petero/drivers/input/mouse/synaptics.c |   68 +++++++++++-------
>  linux-petero/drivers/input/mousedev.c        |  100 +++++++++++++++++++--------
>  linux-petero/include/linux/input.h           |    3 
>  3 files changed, 118 insertions(+), 53 deletions(-)

Yes, this now looks very nice. Applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
