Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751564AbWBWVJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWBWVJW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWBWVJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:09:22 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:7694 "EHLO
	smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751564AbWBWVJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:09:21 -0500
Date: Thu, 23 Feb 2006 22:09:15 +0100
From: thunder7@xs4all.nl
To: Chris Boot <bootc@bootc.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: MD Raid 6: poor algorithm choice?
Message-ID: <20060223210915.GA2800@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <43FDF82A.5050201@bootc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FDF82A.5050201@bootc.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Boot <bootc@bootc.net>
Date: Thu, Feb 23, 2006 at 06:00:10PM +0000
> Hi all,
> 
> [4295106.474000] raid6: mmxx2     2500 MB/s
> [4295106.521000] raid6: sse1x2    2339 MB/s
> [4295106.524000] raid6: using algorithm sse1x2 (2339 MB/s)
> [4295106.531000] md: raid6 personality registered for level 6
> 
> I just loaded the raid6 module for fun (might end up using it one day), and 
> I was surprised at its choice of algorithm. By the messages above, I would 
> have assumed it would choose the mmxx2 algorithm at 2500 MB/s instead of 
> sse1x2 at the slightly slower 2339 MB/s. This is probably entirely expected 
> behaviour, but why?
> 
Because it is more cache-efficient (allows the other code to run at a
higher speed). This comes up now and again, perhaps these messages
should be rephrased.

Jurriaan
-- 
Uhm, well, what we are talking about in privy terms, is the very latest
in front-wall fresh air orifices combined with a wide capacity gutter
installation below.
You mean crap out of the window?
	Blackadder II
Debian (Unstable) GNU/Linux 2.6.16-rc3-mm1 5503 bogomips load load 0.01
