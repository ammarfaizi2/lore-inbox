Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTLQLEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 06:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbTLQLEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 06:04:46 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:28866 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S264292AbTLQLEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 06:04:45 -0500
Date: Wed, 17 Dec 2003 12:03:37 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       wli@holomorphy.com, kernel@kolivas.org, chris@cvine.freeserve.co.uk,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031217110336.GA5615@k3.hellgate.ch>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	wli@holomorphy.com, kernel@kolivas.org, chris@cvine.freeserve.co.uk,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com
References: <20031216112307.GA5041@k3.hellgate.ch> <Pine.LNX.4.44.0312161126520.19925-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312161126520.19925-100000@chimarrao.boston.redhat.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003 11:29:50 -0500, Rik van Riel wrote:
> On Tue, 16 Dec 2003, Roger Luethi wrote:
> 
> > One potential problem with the benchmarks is that my test box has
> > just one bar with 256 MB RAM. The kbuild and efax tests were run with
> > mem=64M and mem=32M, respectively. If the difference between mem=32M
> > and a real 32 MB machine is significant for the benchmark,
> 
> Could you try "echo 0 > /proc/sys/vm/lower_zone_protection" ?

Defaults to 0 anyway, doesn't it? Turning it _on_ seems to slow
benchmarks down somewhat (< 5%). In one of ten runs, though, the efax
test stopped doing anything for ten minutes -- no disk activity, no
progress whatsoever.

Roger
