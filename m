Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVBMTbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVBMTbU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 14:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVBMTbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 14:31:20 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:39602 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261297AbVBMTbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 14:31:16 -0500
Date: Sun, 13 Feb 2005 20:31:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephen Evanchik <evanchsa@gmail.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Message-ID: <20050213193149.GA4315@ucw.cz>
References: <a71293c20502031443764fb4e5@mail.gmail.com> <200502031934.16642.dtor_core@ameritech.net> <200502032252.45309.dtor_core@ameritech.net> <a71293c2050213111345d072b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71293c2050213111345d072b0@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 02:13:15PM -0500, Stephen Evanchik wrote:

> On Thu, 3 Feb 2005 22:52:44 -0500, Dmitry Torokhov
> <dtor_core@ameritech.net> wrote:
> > OK, I have read the code once again, and saw that you have special
> > handling within PS/2 protocol based on model constant. Please set
> > psmouse type to PSMOUSE_TRACKPOINT instead of model and provide full
> > protocol handler, like ALPS, Synaptics and Logitech do. Trackpoint
> > is different and complex enough to warrant it.
> 
> I'm not sure that I think a protocol handler is necessary unless I am
> misunderstanding what you mean. The TrackPoint is nothing more than a
> PS/2 mouse with 2 or 3 buttons that responds to an additional set of
> commands. The extra handling has to do with middle-to-scroll which
> could be done in userspace.
> 
> Aside from that the only time TracKPoint specific processing occurs is
> when some property is being manipulated.
> 
> Do you still think a custom handler is necessary? 
 
You're right. The IBM trackpoints unfortunately don't have a 'native'
mode, they always do full processing and send classic PS/2 packets.

I think we shouldn't need a handler, since we can use the PS/2 protocol
one. We'll need some options to set the trackpoint tap behavior (as far
as I know it can only be mapped to a button), and we'll need a safe
detection, but that's all.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
