Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288248AbSBRWMi>; Mon, 18 Feb 2002 17:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288174AbSBRWM1>; Mon, 18 Feb 2002 17:12:27 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:57354 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S288102AbSBRWMV>; Mon, 18 Feb 2002 17:12:21 -0500
Date: Mon, 18 Feb 2002 22:12:14 +0000
From: Nick Craig-Wood <ncw@axis.demon.co.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: time goes backwards periodically on laptop if booted in low-power mode
Message-ID: <20020218221214.A29199@axis.demon.co.uk>
In-Reply-To: <3C6FDB8C.9B033134@kegel.com> <20020218213049.A28604@axis.demon.co.uk> <3C71780F.6377F8D9@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C71780F.6377F8D9@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Mon, Feb 18, 2002 at 04:54:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 04:54:23PM -0500, Chris Friesen wrote:
> Nick Craig-Wood wrote:
> > I made a patch to fix this (this is its first outing).  It stops
> > do_gettimeofday reporting a time less than it reported last time.
> 
> I see a minor problem here...what happens if you want to reset your clock (for
> whatever purpose) to a previous time?

Sorry that was a simplified explanation above.  If you examine the
patch you'll see that it can only change the time by < 1 jiffy (10ms).
However this is the interval wrongly estimated by the CPU's timer
(because the laptop's clock rate is not what the kernel thinks it is).

Ie, shouldn't be a problem.

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
