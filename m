Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWAATa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWAATa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 14:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWAATa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 14:30:28 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:24288 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932246AbWAATa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 14:30:28 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: ati X300 support?
Date: Sun, 1 Jan 2006 19:28:37 +0000
User-Agent: KMail/1.9
Cc: chris@pcburn.com, Gerhard Mack <gmack@innerfire.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0512261858200.28109@innerfire.net> <200512272320.45378.s0348365@sms.ed.ac.uk> <1135798330.16657.1.camel@localhost>
In-Reply-To: <1135798330.16657.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601011928.37152.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 December 2005 19:32, Kasper Sandberg wrote:
[snip]
> >
> > Yes, you and this link are both out of date. The r300 driver provides
> > basic support for many newer video cards based on the r300 core and is
> > shipped with Xorg 7.0.0.
>
> is this only 7.0.0? i just built 6.9 and i dont have the 'r300' x
> driver, or... is it merged into the 'ati' or 'radeon' xorg driver
> module?
>

Sorry for the delay Kasper, the driver is still "ati"; if you have DRI 
compiled and enabled, the "ati" driver will attempt to set up DRI via the 
r300_dri.so that should exist in either /usr/X11R7/lib/modules/dri, 
or /usr/X11R7/lib/xorg/modules/dri.

You'll need a fairly recently kernel with drm support for r300/r400, but it 
seems to work OOTB.

If you do NOT have the dri drivers, it is trivial to install them. Download 
MesaLib-6.4.1, then issue:

make linux-dri

When this finishes, point the installer to the right directory. I initially 
made the mistake of pointing it directly to /usr/X11R7/lib, but it copies the 
XXX_dri.so's to this directory, so it should actually 
be /usr/X11R7/lib/modules/dri (create this directory prior to installation)..

..and that should be it.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
