Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbTFTU6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbTFTU47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:56:59 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:48352 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264706AbTFTU4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:56:49 -0400
Date: Fri, 20 Jun 2003 23:10:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: =?iso-8859-2?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [Must-fix] Keyboard occasionally endlessly repeating keys
Message-ID: <20030620231043.A20869@ucw.cz>
References: <20030620202444.GD22732@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030620202444.GD22732@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Fri, Jun 20, 2003 at 10:24:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 10:24:44PM +0200, Jörn Engel wrote:

> After having upgraded my notebook to 2.5.72, I noticed a rare problem,
> that occurs about twice a day, maybe more.  After pressing a key, it
> gets repeated endlessly until the next key is pressed.  When typing
> fast, it is quite possible to cover up a couple of these, as the
> repeats appear to happen at the set keyboard rates.  Problem never
> occured with any 2.4 kernel.
> 
> I remember having read about this problem on the list before, but
> didn't search my archive yet.  Also, I consider this to be a show
> stopper, as the bug is already nasty when hitting 'q' inside mutt once
> and might have worse effects with other programs.  YMMV.

Yes, I know about the problem. I wasn't able to pin it down yet, though.
It looks like the keyboard might just 'forget' to send a key release.
This is not a problem on 2.4, since 2.4 uses the keyboard hardware
autorepeat. 2.5 does autorepeat in software and if the keyboard doesn't
send the release, well ...

But it might be a software problem, too. If you want to help, you can
run with I8042_DEBUG_IO enabled all the time and send me the log from
around the point in time when it happened.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
