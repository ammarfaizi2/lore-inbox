Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277347AbRJZCnH>; Thu, 25 Oct 2001 22:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277353AbRJZCmr>; Thu, 25 Oct 2001 22:42:47 -0400
Received: from queen.bee.lk ([203.143.12.182]:62593 "EHLO queen.bee.lk")
	by vger.kernel.org with ESMTP id <S277347AbRJZCmk>;
	Thu, 25 Oct 2001 22:42:40 -0400
Date: Fri, 26 Oct 2001 08:43:28 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: linux-kernel@vger.kernel.org
Subject: Other computers HIGHLY degrading network performance (DoS?)
Message-ID: <20011026084328.A14814@bee.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is not a direct kernel issse.  However, it is a serious threat for the
network performance of our Linux boxes, therefore I thought of posting it here.

There is a popular software that runs on MS platform called "download
accelerator".  This opens several threads for a download job (each one
downloading a portion of the file), sometimes even using mirror sites.
However, it not only grabs whole bandwidth, but makes it hard for other
machines to even ping each other the return time being around 5-10 seconds on a
100 Mbps network!  The download process is getting only 64 kbps from the
Internet.  Internet access is virtually impossible for the other machines.

This program can run with a `normal download' mode and this doesn't cause a
big problem.

I monitored network traffic with tcpdump, and noticed that those packets don't
have tcp timestamps and tcp sack.  I turned them off on my Linux box using
sysctl, and also tried turning on ECN without success.

This is of course a DoS in disguise, and is there a way to stop it?

I am thinking of setting up a firewall with netfilter and transparent proxy as
a workaround.

Thanks in advance.

Regards,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.13)

History books which contain no lies are extremely dull.

