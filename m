Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTEOVBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 17:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTEOVBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 17:01:00 -0400
Received: from ida.rowland.org ([192.131.102.52]:7940 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264265AbTEOVA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 17:00:59 -0400
Date: Thu, 15 May 2003 17:13:40 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       <johannes@erdfelt.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
In-Reply-To: <1053027740.2095.44.camel@diemos>
Message-ID: <Pine.LNX.4.44L0.0305151709120.1125-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 May 2003, Paul Fulghum wrote:

> The erratum is only for the PIIX4, and it is
> triggered only when the OC inputs are active,
> so limiting the check to that device should
> be OK.
> 
> Probably the least intrusive thing to do
> is to disable suspending the uhci controller
> if it is a PIIX4 *and* either port has an
> over current condition. This will catch the case
> of a functional USB controller that has one
> or more real over current conditions and the
> case of a deliberately disabled (by hardwiring
> the OC inputs) controller. The erratum will
> pop up in both cases causing suspend<->wake
> thrashing.

My intention was to avoid resuming if the resume-detect bit is set only 
on ports in an over-current condition, since that is the case mentioned in 
the erratum.  Of course, this isn't as failsafe as your suggestion.  Which 
do you think would work better?

Alan Stern

