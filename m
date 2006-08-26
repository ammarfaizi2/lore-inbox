Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWHZUg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWHZUg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 16:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWHZUg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 16:36:59 -0400
Received: from science.horizon.com ([192.35.100.1]:57655 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750873AbWHZUg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 16:36:58 -0400
Date: 26 Aug 2006 16:30:48 -0400
Message-ID: <20060826203048.2463.qmail@science.horizon.com>
From: linux@horizon.com
To: ian.stirling@mauve.plus.com, linux@horizon.com
Subject: Re: Serial custom speed deprecated?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44F0A310.4010107@mauve.plus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To nitpick.
> For a 10 bit long word, if the receiver syncs to within 1/8th of  the 
> middle of a bit-time at the start, you've got 2/8th of a bit-time of 
> disagreement possible, before you are likely to get errors, especially 
> on limited slew-rate signals. (more modern chips will likely sample faster)
> Or 3/80, or 2.5%. If the other side has made a similar calculation, then 
> you should only really rely on 1%.
> 5% is the best possible case - that will in most circumstances cause errors.

You're quite right; 5% assumes perfect signal edges, which you don't
get in practice, especially at high baud rates.  Also, you have
frational stop bit tricks from some modems.

Still, as I suggested, half-precision floating point (1 sign, 5 exponent,
10 mantissa) as used for HDR graphics has a relative error range of 1/1024
(0.098%) to 1/2047 (0.049%), and would be an excellent match.

It's not a terribly serious suggestion, as I don't think 134.5 baud
is a serious issue these days, but it does make clear that there's no
difference between 115,200 baud and 115,299 baud.
