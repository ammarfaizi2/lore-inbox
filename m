Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUFNEYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUFNEYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 00:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUFNEYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 00:24:23 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:31507 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261857AbUFNEYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 00:24:21 -0400
Date: Mon, 14 Jun 2004 06:21:39 +0200
From: Willy Tarreau <willy@w.ods.org>
To: ndiamond@despammed.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Panics need better handling
Message-ID: <20040614042139.GD29808@alpha.home.local>
References: <200406140223.i5E2N1k18221@mailout.despammed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406140223.i5E2N1k18221@mailout.despammed.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 13, 2004 at 09:23:01PM -0500, ndiamond@despammed.com wrote:
> Is there
> any chance in getting the 24 most
> important lines of panic information
> displayed last, and putting the cursor
> at the end of the 24th line thereof, so
> that 24 valuable lines of panic
> information can be visible?

You could try kmsgdump, which Randy Dunlap ported to 2.6 :

   http://developer.odsl.org/rddunlap/kmsgdump/

Upon panic, it switches real mode, uses the bios to change display to text
mode (which does not work for every video card, but still most of them),
then put you in an interactive screen in which you can scroll the last
32 kB of kernel messages, then decide to dump them on a floppy disk or
print them on a parallel printer. This can also be configured to dump
automatically without user interaction and automatically reboot once
done.

Clearly what you need it seems,
Willy

