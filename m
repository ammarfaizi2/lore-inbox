Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTJTU7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbTJTU7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:59:47 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:22703
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262787AbTJTU7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:59:43 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Subject: Re: Wow.  Suspend to disk works for me in test8. :)
Date: Mon, 20 Oct 2003 15:56:43 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200310200225.11367.rob@landley.net> <3F93BCCB.1050406@mscc.huji.ac.il>
In-Reply-To: <3F93BCCB.1050406@mscc.huji.ac.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310201556.43520.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 October 2003 05:45, Voicu Liviu wrote:
> Rob Landley wrote:
> >Good grief.  It worked.
> >
> >echo -n disk > /sys/power/state
>
> How long does it take to do suspend to disk?

I haven't actually timed it, but it feels like somewhere around 15 seconds.  
(I just close the lid and pack the thing away while it's doing it, haven't 
really been paying attention...)

Coming back takes about the same time.  It's not instant on, but it's a 
distinct improvement.

A couple of down sides I've noticed: I have to run "hwclock --hctosys" after a 
resume because the time you saved at is the time the system thinks it is when 
you resume (ouch).  And because of that, things that should time out and 
renew themselves (like dhcp leases) have to be thumped manually.

But other than that... :)

Rob
