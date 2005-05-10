Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVEJEYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVEJEYh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 00:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVEJEYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 00:24:33 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:2315 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261542AbVEJEYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 00:24:30 -0400
Date: Tue, 10 May 2005 06:12:37 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jim Nance <jlnance@sdf.lonestar.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050510041237.GA32065@alpha.home.local>
References: <20050508012521.GA24268@SDF.LONESTAR.ORG> <427FA876.7000401@tmr.com> <20050510022301.GA13763@SDF.LONESTAR.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510022301.GA13763@SDF.LONESTAR.ORG>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

On Tue, May 10, 2005 at 02:23:01AM +0000, Jim Nance wrote:
 
> Now I know there are exceptions to rules.  But in general I would say
> that if an application needs to know about the configuration of the
> processors, then its compensating for shortcommings in the kernel.

I cannot agree. When an application needs to know such things, it is
because it has being developped primarily for a certain platform and
optimized for such platform. The kernel's scheduler is written for a
general purpose and not for some particular apps which will run two
concurrent threads at 100% CPU each for example, with lots of memory
exchanges through the CPU cache. It is not uncommon to have to manually
play with /proc before starting some specific apps. It is for this case
that some help from the kernel might be welcome. Instead of forcing eth0
interrupt to CPU0 then binding your process to CPU0, you might prefer to
tell the kernel "this app needs to run on the CPU which receives ints
from eth0", whatever it is.

Regards,
willy

