Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbTEMBzw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 21:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbTEMBzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 21:55:52 -0400
Received: from fmr02.intel.com ([192.55.52.25]:31728 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262531AbTEMBzu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 21:55:50 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780CCB0453@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: "'Chris Friesen'" <cfriesen@nortelnetworks.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: how to measure scheduler latency on powerpc?  realfeel doesn'
	 t work due to /dev/rtc issues
Date: Mon, 12 May 2003 19:08:30 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: William Lee Irwin III [mailto:wli@holomorphy.com]
> 
> From: William Lee Irwin III [mailto:wli@holomorphy.com]
> >> This is ridiculous. Just make sure you're not sharing interrupts and
> >> count cycles starting at the ISR instead of wakeup and tag events
> >> properly if you truly believe that to be your metric. You, as the
> >> kernel, are notified whenever the interrupts occur and can just look
> >> at the time of day and cycle counts.
> 
> On Mon, May 12, 2003 at 05:20:39PM -0700, Perez-Gonzalez, Inaky wrote:
> > Well, I am only suggesting a way to _FORCE_ interrupts to happen
> > at a certain rate controllable by _SOMEBODY_, not as the system
> > gets them. Chris was concerned about not having a way to
> > _GENERATE_ interrupts at a certain rate.
> > What you are suggesting is the other part of the picture, how to
> > measure the latency and AFAICS, it is not part of the problem of
> > generating the interrupts.
> 
> It also seems somewhat pointless to measure it under artificial
> conditions. Interrupts happen often anyway and you probably want to

Your artificial conditions are your control measurements. Then you
add the loads in the background; by being able to selectively add
and remove loads (the real live loads), then you can more easily
identify who is causing delays and under what conditions. It is
not as thorough as a full code analysis ... but if your coverage
is well done can help a lot.

But I am sure you know all this already.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
