Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267721AbUJLUJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267721AbUJLUJM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUJLUJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:09:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:45744 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267721AbUJLUJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:09:02 -0400
Date: Tue, 12 Oct 2004 13:08:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       wli@holomorphy.com
Subject: Re: [BUG]  oom killer not triggering in 2.6.9-rc3
Message-ID: <20041012130859.G2441@build.pdx.osdl.net>
References: <41672D4A.4090200@nortelnetworks.com> <1097503078.31290.23.camel@localhost.localdomain> <416B6594.5080002@nortelnetworks.com> <20041012094439.GA3223@pclin040.win.tue.nl> <416BF927.7000000@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <416BF927.7000000@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Tue, Oct 12, 2004 at 09:32:55AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Friesen (cfriesen@nortelnetworks.com) wrote:
> However, isn't it a bad thing that a vanilla 2.6.9-rc3 can be totally locked up 
> by an unpriviledged user by running two tasks?

Chris, did you try the patch I sent you (it's in mainline now, so if you
re-test on 2.6.9-rc4 you'd pick it up)?  With that patch, with 2G of
memory and no swap, my machine did not lock up, and the conditions that
the patch protect against were triggered.  And, with the patch backed
out, kswapd spins out of control.  I believe this is fixed.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
