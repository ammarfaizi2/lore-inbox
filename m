Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263607AbUEGPG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUEGPG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263615AbUEGPG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:06:57 -0400
Received: from [151.38.86.74] ([151.38.86.74]:18692 "EHLO gateway.milesteg.arr")
	by vger.kernel.org with ESMTP id S263607AbUEGPGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:06:50 -0400
Date: Fri, 7 May 2004 17:06:37 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sis900 fix (Was: [CHECKER] Resource leaks in driver shutdown functions)
Message-ID: <20040507150637.GB12798@picchio.gall.it>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <3580.171.64.70.92.1083609961.spork@webmail.coverity.com> <20040504084326.GA11133@gateway.milesteg.arr> <200405061223.40942.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405061223.40942.rob@landley.net>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 12:23:40PM -0500, Rob Landley wrote:
> Does this fix the problem where you unplug the cat 5 cable from an SiS900 and 
> then plug it back in (toggling the MII tranciever link detect status and all 
> that), and the device goes positively mental until you reboot the system?  
> (Packets randomly dropped or delayed for up to 15 seconds, and arriving out 
> of sequence with horrible impacts on performance?)
> 
> I tried pursuing this when I first noticed it circa 2.4.4, but as you say,
> the driver is unmaintained and I haven't got specs (or any clue about) the 
> chipset...
I was not aware of this problem, the driver is slow to recognize the
link status of the interface and often needs sending some packets before
switching to link status on. But on my sis900 (on a laptop) I never
observed a behavior similar to yours.

The patch I submitted is a small fix in the power management code, so
it's very unlikely that it fixes anything in the link detection,
please also note that the patch is for kernels 2.6.x.

The driver in 2.6 has some small differencies that probably are fixes
never backported, is the driver in 2.4 also broken for other people ?
Are you using the 2.6 or 2.4 driver ?

Thanks for the feedback.
-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

