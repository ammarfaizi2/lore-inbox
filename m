Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbUL1DgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUL1DgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 22:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbUL1DgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 22:36:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60177 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262043AbUL1DgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 22:36:19 -0500
Date: Tue, 28 Dec 2004 04:36:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/ipv4/: misc possible cleanups
Message-ID: <20041228033617.GI5345@stusta.de>
References: <20041215005139.GJ23151@stusta.de> <20041227191535.5edce690.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227191535.5edce690.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 07:15:35PM -0800, David S. Miller wrote:
> On Wed, 15 Dec 2004 01:51:39 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > - remove the following unneeded EXPORT_SYMBOL:
> >   - tcp_timer.c: tcp_timer_bug_msg
> 
> This one is wrong.  It is needed for the ipv6 module
> via the call tcp_ipv6.c makes to tcp_done() which
> invokes tcp_clear_xmit_timer() which uses
> tcp_timer_bug_msg.

tcp_done doesn't call tcp_clear_xmit_timer, it calls 
tcp_clear_xmit_timers (note the s) which is not an inline but an 
EXPORT_SYMBOL'ed function in tcp_timer.c.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

