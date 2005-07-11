Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVGKKre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVGKKre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 06:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVGKKre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 06:47:34 -0400
Received: from styx.suse.cz ([82.119.242.94]:39637 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261619AbVGKKrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 06:47:33 -0400
Date: Mon, 11 Jul 2005 12:47:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian@popies.net>
Cc: Peter Osterlund <petero2@telia.com>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
Message-ID: <20050711104732.GB23309@ucw.cz>
References: <20050708101731.GM18608@sd291.sivit.org> <1120821481.5065.2.camel@localhost> <20050708121005.GN18608@sd291.sivit.org> <20050709191357.GA2244@ucw.cz> <m33bqnr3y9.fsf@telia.com> <20050710120425.GC3018@ucw.cz> <m3y88e9ozu.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3y88e9ozu.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 02:15:49AM +0200, Peter Osterlund wrote:

> I took the liberty to modify the patch myself, making these changes:
> 
> * Removed the extra filtering.
> * Converted the "open" counter to an "open" flag. (It is still needed
>   by the atp_resume() function.)
> * CodingStyle fixes.
> 
> I have only compile tested this as I don't have access to the
> hardware, so I don't know how well this works in practice. It's
> possible that the "dev->h_count > 3" test in the old patch filtered
> out spikes in the input signal.
> 
> Also, it might be a good idea to compute an ABS_PRESSURE value instead
> of hardcoding it to 100. I think the psum variable in
> atp_calculate_abs() can be used, possibly after rescaling.

Stelian, can you check the patch, and if everything is OK, add your
Signed-off-by: line?

> Signed-off-by: Peter Osterlund <petero2@telia.com>
> ---
> 
>  Documentation/input/appletouch.txt |  120 +++++++++
>  drivers/usb/input/Kconfig          |   19 +
>  drivers/usb/input/Makefile         |    1 
>  drivers/usb/input/appletouch.c     |  461 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 601 insertions(+), 0 deletions(-)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
