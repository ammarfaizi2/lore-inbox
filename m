Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWAKXIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWAKXIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWAKXIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:08:36 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:31153 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932521AbWAKXIf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:08:35 -0500
Subject: Re: [PATCH 3/10] NTP: add ntp_update_frequency
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1137020731.2890.74.camel@cog.beaverton.ibm.com>
References: <Pine.LNX.4.61.0512220021210.30900@scrub.home>
	 <1137020731.2890.74.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 15:08:13 -0800
Message-Id: <1137020893.2890.75.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 15:05 -0800, john stultz wrote:
> On Thu, 2005-12-22 at 00:21 +0100, Roman Zippel wrote:
> > This introduces ntp_update_frequency and deinlines ntp_clear() (as it's
> > not performance critical).
> > It also changes how tick_nsec is calculated from tick_usec, instead of
> > scaling it using TICK_USEC_TO_NSEC it's simply shifted by the difference.
> > Since ntp doesn't change the tick value, the result in practice is the
> > same, but it's easier to change this into a clock parameter, which can
> > be calculated during boot.
> > 

One last thing, shouldn't this patch kill TICK_USEC_TO_NSEC ?

thanks
-john


