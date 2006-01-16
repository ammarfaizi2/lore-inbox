Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWAPTKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWAPTKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 14:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWAPTKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 14:10:11 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:26024 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1750859AbWAPTKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 14:10:09 -0500
Date: Mon, 16 Jan 2006 21:07:52 +0200 (EET)
From: Samuel Ortiz <samuel.ortiz@nokia.com>
X-X-Sender: samuel@irie
Reply-To: samuel.ortiz@nokia.com
To: ext Stuffed Crust <pizza@shaftnet.org>
cc: Sam Leffler <sam@errno.com>, Jeff Garzik <jgarzik@pobox.com>,
       Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
In-Reply-To: <20060116172817.GB8596@shaftnet.org>
Message-ID: <Pine.LNX.4.58.0601162056261.17348@irie>
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com>
 <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com>
 <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org>
 <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org>
 <43CAA853.8020409@errno.com> <20060116172817.GB8596@shaftnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Jan 2006 19:07:50.0578 (UTC) FILETIME=[252BB920:01C61AD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, ext Stuffed Crust wrote:

> Background scanning, yes -- but there are all sorts of different
> thresholds and types of 'scanning' to be done, depending on how
> disruptive you are willing to be, and how capable the hardware is.  Most
> thin MACs don't filter out foreign BSSIDs on the same channel when
> you're joined, which makes some things a lot easier.
That is true, thin MACs usually don't filter beacons on the same channel.
But in some cases (mainly power saving), you really want to avoid
receiving useless beacons and having the host woken up for each of them.
You may even want to not receive all the useful ones (the ones coming from
the AP you're joined with) if your softmac allows that.
This kind of beacon filtering is a big power saver, which is one of the
most important requirement for some platforms (phones, PDA, etc...).

Cheers,
Samuel.
