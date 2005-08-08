Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVHHIZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVHHIZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 04:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVHHIZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 04:25:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:59865 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750760AbVHHIZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 04:25:07 -0400
Subject: Re: Regression: radeonfb: No synchronisation on CRT with
	linux-2.6.13-rc5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0508080158520.7822@be1.lrz>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>
	 <1123195493.30257.75.camel@gaston>
	 <Pine.LNX.4.58.0508051935570.2326@be1.lrz>
	 <1123401069.30257.102.camel@gaston>
	 <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>
	 <Pine.LNX.4.58.0508071921540.3495@be1.lrz>
	 <1123451289.30257.118.camel@gaston>
	 <Pine.LNX.4.58.0508080158520.7822@be1.lrz>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 10:19:59 +0200
Message-Id: <1123489200.30257.133.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 02:06 +0200, Bodo Eggert wrote:

> The wrong values are constant across reboots (see my first mail), and I 
> have a CRT.
> 
> Can you tell me where the timing values are read?

radeon_write_mode() programs the mode. The monitor timing infos are read
by the various bits of code in radeon_monitor.c

I'd be curious if you could identify what bit of code is misbehaving

Ben.


