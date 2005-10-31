Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVJaMrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVJaMrs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 07:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVJaMrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 07:47:47 -0500
Received: from styx.suse.cz ([82.119.242.94]:21893 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932125AbVJaMrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 07:47:47 -0500
Date: Mon, 31 Oct 2005 13:47:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT/PATCH] atkbd - speed up setting leds/repeat state
Message-ID: <20051031124746.GC18147@ucw.cz>
References: <200510310224.03010.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510310224.03010.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 02:24:02AM -0500, Dmitry Torokhov wrote:
> Input: atkbd - speed up setting leds/repeat state
> 
> Changing led state is pretty slow operation; when there are multiple
> requests coming at a high rate they may interfere with normal typing.
> Try optimize (skip) changing hardware state when multiple requests
> are coming back-to-back.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
 
It looks good - just two comments:

	1) wmb() shouldn't be needed after set_bit()

	2) maybe we want to enforce the delay before we send the 
           next SET_LED command.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
