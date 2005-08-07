Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752294AbVHGQhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbVHGQhq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 12:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbVHGQhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 12:37:46 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:39615 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S1752294AbVHGQhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 12:37:45 -0400
Date: Sun, 7 Aug 2005 19:37:42 +0300
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: assertion (cnt <= tp->packets_out) failed
Message-ID: <20050807163742.GN27323@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heikki Orsila wrote:
> There were big changes in tcp_output.c between rc1 and rc2, and the 
> bug is triggered when using e1000 with rc2 or later. And because the 
> bug does not happen on skge (new sk98 driver) it makes me guess it's a 
> race condition of sorts.. I am surprised this bug wasn't noticed with 
> rc2.

One more bit of info: there was no e1000 driver changes between rc1 and 
rc2, which increases the evidence that the error was induced by
tcp_output.c.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
