Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272637AbTHGAaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 20:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275016AbTHGA3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 20:29:44 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:59663 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272637AbTHGA3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 20:29:34 -0400
Date: Thu, 7 Aug 2003 02:29:31 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Timothy Miller <miller@techsource.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Patrick Moor <pmoor@netpeople.ch>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>
Subject: Re: time jumps (again)
Message-ID: <20030807002931.GA5454@win.tue.nl>
References: <Pine.LNX.4.33.0308042347300.12309-100000@gans.physik3.uni-rostock.de> <3F314603.7050907@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F314603.7050907@techsource.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 02:16:35PM -0400, Timothy Miller wrote:

> Is there any way the kernel could detect clock problems like drift and 
> jumps by comparing the effects of different timers?  And when a problem 
> is detected, it can correct the situation automatically.

In this particular case, I think my stopgap
	if ((long) usec < 0)
		usec = 0;
would suffice to eliminate the jumps.
Of course it would be better to understand the hardware details,
but perhaps we are insufficiently documented.

