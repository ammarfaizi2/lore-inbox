Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbVIZNQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbVIZNQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 09:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVIZNQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 09:16:20 -0400
Received: from triton.rz.uni-saarland.de ([134.96.7.25]:64541 "EHLO
	triton.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S1750880AbVIZNQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 09:16:19 -0400
From: Michael Bellion <mbellion@hipac.org>
To: hadi@cyberus.ca
Subject: Re: [ANNOUNCE] Release of nf-HiPAC 0.9.0
Date: Mon, 26 Sep 2005 15:16:16 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
References: <200509260445.46740.mbellion@hipac.org> <1127733492.6215.274.camel@localhost.localdomain>
In-Reply-To: <1127733492.6215.274.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261516.16565.mbellion@hipac.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.1 (triton.rz.uni-saarland.de [134.96.7.25]); Mon, 26 Sep 2005 15:16:17 +0200 (CEST)
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.32.0.6; VDF 6.32.0.43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Can you post some numbers relative to iptables?

We have some performance tests available at:
http://www.hipac.org/performance_tests/overview.html

We also have a list of the independent performance tests we know of:
http://www.hipac.org/performance_tests/independent.html

> Some tests with the following parameters would be helpful:
> - Variable incoming packet rate (in packets per second)
> - Variable packet sizes
> - Variable number of users/filters
> - Effect of adding/removing/modifying policies while under different
> incoming traffic rates.

Most of this parameters are used in the performance tests above.

The effect of adding/removing/modifying policies while under different
incoming traffic rates has not been tested in the above tests.

nf-HiPAC is based on a completely dynamic approach.
This means that the algorithm used in HiPAC makes sure that the lookup data 
structure is not rebuild from scratch again as soon as you make a update of 
the data structure.
Instead during an update of the policies only the required changes of the 
lookup data structure are made. This guaranties that the packet processing is 
only affected to the least possible amount during updates.

It would certainly be nice to see some benchmark results for this case. 
nf-HiPAC is expected to handle this very well, because it was designed with 
this case in mind.

Regards
    +---------------------------+
    |      Michael Bellion      |
    |   <mbellion@hipac.org>    |
    +---------------------------+
