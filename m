Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVL3TQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVL3TQl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 14:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbVL3TQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 14:16:41 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:33668 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751290AbVL3TQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 14:16:41 -0500
Subject: Re: [linux-usb-devel] Re: EHCI TT bandwidth (was Re: [PATCH]
	USB_BANDWIDTH documentation change)
From: Lee Revell <rlrevell@joe-job.com>
To: ddstreet@ieee.org
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>, Bodo Eggert <7eggert@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.51.0512301407200.28360@dylan.root.cx>
References: <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org>
	 <200512270857.35505.david-b@pacbell.net>
	 <Pine.LNX.4.51.0512291433090.27091@dylan.root.cx>
	 <1135886739.6804.4.camel@mindpipe>
	 <Pine.LNX.4.51.0512301407200.28360@dylan.root.cx>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 14:16:38 -0500
Message-Id: <1135970198.31111.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 14:13 -0500, Dan Streetman wrote:
> On Thu, 29 Dec 2005, Lee Revell wrote:
> 
> >How do I test them?  Should this make USB audio work with
> >CONFIG_USB_BANDWIDTH?
> 
> It won't have any effect on CONFIG_USB_BANDWIDTH, as the EHCI transaction 
> translator scheudling code doesn't care about that config setting.  This 
> also won't have any effect on USB 2.0 devices (e.g. a highspeed Audio 
> device).
> 
> The updates will only help in the situation where there are multiple
> lowpseed or fullspeed devices with periodic endpoints, all connected to
> the same USB 2.0 (highspeed) hub.  In that situation it's possible to
> "fill up" the USB 2.0 hub's transaction translator periodic schedule with
> only a few devices.  The updates allow many more devices to fit in the
> TT's periodic schedule.  The specific number of devices depends on how 
> many periodic endpoints, those endpoint's poll rates, and their max packet 
> sizes.
> 

OK.  For some reason I though that problem was fixed, I guess it was a
different issue.  ALSA users previously reported that a full speed audio
device didn't work at all through a high speed hub at all but that it
was fixed a few months ago.

Lee

