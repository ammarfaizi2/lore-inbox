Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266528AbUFUX4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266528AbUFUX4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 19:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266530AbUFUX4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 19:56:33 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:65110 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S266528AbUFUX4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 19:56:31 -0400
Message-ID: <40D775AE.60806@microgate.com>
Date: Mon, 21 Jun 2004 18:56:30 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird M6a (Windows/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Aloni <da-x@colinux.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing NULL check in drivers/char/n_tty.c
References: <20040621063845.GA6379@callisto.yi.org> <20040620235824.5407bc4c.akpm@osdl.org> <20040621073644.GA10781@callisto.yi.org> <20040621003944.48f4b4be.akpm@osdl.org> <20040621082430.GA11566@callisto.yi.org> <40D6F986.3010904@microgate.com> <20040621114605.4df2c05e.akpm@osdl.org> <20040621224829.GA26607@callisto.yi.org>
In-Reply-To: <20040621224829.GA26607@callisto.yi.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:

>Apropos cleanups in the tty subsystem, what is the purpose of all 
>the *_paranoia_check() calls that almost every driver duplicates for 
>itself? Perhaps this can be removed.
>
At some time in the distant past, it must have been a brute force
attempt to debug some *serious* problems. I've never had the
need to enable those checks in the last 6 years.

I agree with your thought, and will be removing them from at
least the synclinkxx drivers. The checks clutter the code
with little gain. And cruft like that keeps propogating to new drivers.

--
Paul Fulghum
paulkf@microgate.com


