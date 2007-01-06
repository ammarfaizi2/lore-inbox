Return-Path: <linux-kernel-owner+w=401wt.eu-S932204AbXAFUwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbXAFUwf (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbXAFUwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:52:35 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:55665 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbXAFUwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:52:33 -0500
Subject: Re: [PATCH] cx88xx: Fix lockup on suspend
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Reply-To: nigel@nigel.suspend2.net
To: Robert Hancock <hancockr@shaw.ca>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <459FE9B7.3070601@shaw.ca>
References: <fa.zlXsUuWZNMJXOVESY6BoJRtki8Y@ifi.uio.no>
	 <fa.mPiA9bh9SZGXd2TrS/eQjWPc9oA@ifi.uio.no>  <459FE9B7.3070601@shaw.ca>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 07:52:31 +1100
Message-Id: <1168116751.2674.5.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2007-01-06 at 12:25 -0600, Robert Hancock wrote:
> Pavel Machek wrote:
> > Ack,
> >   
> > but your patch was whitespace-damaged. Can you retry?
> >   
> 
> Here's another try with it attached (Thunderbird is deciding to be a
> pain unfortunately..)
> 
> ---
> 
> Suspending with the cx88xx module loaded causes the system to lock up
> because the cx88_audio_thread kthread was missing a try_to_freeze()
> call, which caused it to go into a tight loop and result in softlockup
> when suspending. Fix that.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

Signed-off-by: Nigel Cunningham <nigel@nigel.suspend2.net>


I have just gotten a cx88 card and had to do the same thing, but hadn't
had time to send the patch yet. The cards (or at least my one) need more
attention than this though; after resuming mine doesn't tune.

Regards,

Nigel

