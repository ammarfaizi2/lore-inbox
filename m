Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbTFTS35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTFTS35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:29:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:33532 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264173AbTFTS3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:29:54 -0400
Message-Id: <200306201843.h5KIhnvI114576@westrelay04.boulder.ibm.com>
From: john stultz <johnstul@us.ibm.com>
Subject: Re: strange clock fastness with 2.5.70 and chipset i810
To: venom@sns.it, linux-kernel@vger.kernel.org
Mail-Copies-To: johnstul@us.ibm.com
Date: Fri, 20 Jun 2003 11:35:55 -0700
References: <Pine.LNX.4.43.0305281127330.14588-100000@cibs9.sns.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

venom@sns.it wrote:

> I just upgraded on a test pc to kernel 2.5.70.
> with this kernel the system clock has become e lot faster (the
> same happens with 2.5.69 too), so what the system thinks to be a second,
> is more or le 0,6 real seconds.
> 
> setting HZ to 100 slows down a little, so a system second is almost 0,8
> real seconds.
> 
> going back to 2.5.66 or 2.4.20 solves the problem.


Sorry for missing this earlier. This issue is being tracked in bug 827.
http://bugme.osdl.org/show_bug.cgi?id=827

The current workaround is booting w/ "clock=pit" but I just sent a patch to
Andrew requesting we disable the lost-ticks code until this is properly
fixed.

thanks
-john

