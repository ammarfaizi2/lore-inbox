Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTFYIx2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 04:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTFYIx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 04:53:28 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:22923 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264437AbTFYIx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 04:53:26 -0400
Date: Wed, 25 Jun 2003 11:07:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Must-fix] Keyboard occasionally endlessly repeating keys
Message-ID: <20030625090723.GA10864@wohnheim.fh-wedel.de>
References: <20030620202444.GD22732@wohnheim.fh-wedel.de> <1056495483.1027.260.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1056495483.1027.260.camel@w-jstultz2.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 June 2003 15:58:04 -0700, john stultz wrote:
> On Fri, 2003-06-20 at 13:24, Jörn Engel wrote:
> > After having upgraded my notebook to 2.5.72, I noticed a rare problem,
> > that occurs about twice a day, maybe more.  After pressing a key, it
> > gets repeated endlessly until the next key is pressed.  When typing
> > fast, it is quite possible to cover up a couple of these, as the
> > repeats appear to happen at the set keyboard rates.  Problem never
> > occured with any 2.4 kernel.
> 
> Assuming you're still seeing this, does booting w/ "clock=pit" resolve
> the problem? If so could you send me more info about the system? (is
> speed step enabled, etc?)

Problem appears to be from hardware, Vojtech Pavlik helped me a bit to
track it down.  Hardware occasionally doesn't send the key release
signal after a key pressed signel.

System is IBM Thinkpad R30, CPU permanently running on low speed
(700MHz), no speed step (unsupported chipset).

Should I still test w/ clock=pit?

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918
