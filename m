Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVIQFuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVIQFuX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 01:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVIQFuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 01:50:22 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:1796 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750947AbVIQFuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 01:50:22 -0400
Date: Sat, 17 Sep 2005 07:50:10 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Eradic disk access during reads
Message-ID: <20050917055010.GG30279@alpha.home.local>
References: <200509170717.03439.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509170717.03439.a1426z@gawab.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 07:26:11AM +0300, Al Boldi wrote:
> Monitoring disk access using gkrellm, I noticed that a command like
> 
> cat /dev/hda > /dev/null
> 
> shows eradic disk reads ranging from 0 to 80MB/s on an otherwise idle system.
> 
> 1. Is this a hardware or software problem?

Difficult to tell without more info. Can be a broken IDE disk or defective
ribbon.

> 2. Is there a lightweight perf-mon tool (cmd-line) that would log this 
> behaviour graphically?

You can do " readspeed </dev/hda | tr '\r' '\n' > log " with the readspeed
tool from there :
   http://w.ods.org/tools/readspeed

Then you just have to graph $6 (kB/s) versus $1 (bytes read). There may
be other tools which do all this automatically though.

Regards,
Willy

