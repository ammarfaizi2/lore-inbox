Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbTK0Njp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 08:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264520AbTK0Njp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 08:39:45 -0500
Received: from holomorphy.com ([199.26.172.102]:55232 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264519AbTK0Njo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 08:39:44 -0500
Date: Thu, 27 Nov 2003 05:39:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Nick Piggin <piggin@cyberone.com.au>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
Message-ID: <20031127133929.GX8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gene Heskett <gene.heskett@verizon.net>,
	Nick Piggin <piggin@cyberone.com.au>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <Pine.LNX.4.58.0311261202050.1524@home.osdl.org> <3FC5B8B2.7000702@cyberone.com.au> <200311270505.50242.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311270505.50242.gene.heskett@verizon.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 27, 2003 at 05:05:50AM -0500, Gene Heskett wrote:
> My $0.02, but performance like that would scare a new user right back 
> to winderz.
> Around here, its thanksgiving day, and we traditionally eat way too 
> much turkey (or something like that :)  And then complain about the 
> weight we've gained of course...

This isn't a performance problem. This is a bug. It vaguely sounds like
a missed wakeup or missing setting of TIF_NEED_RESCHED, but could be a
number of other things too.

(The missing setting of TIF_NEED_RESCHED theory is right if it's
possible to clean up after it by ignoring need_resched() in the
scheduler and always rescheduling.)


-- wli
