Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265267AbUGGSHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUGGSHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUGGSHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:07:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:15822 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265263AbUGGSHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:07:12 -0400
Date: Wed, 7 Jul 2004 11:06:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: bert hubert <ahu@ds9a.nl>, jamie@shareable.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
Message-Id: <20040707110653.7c49bef1@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040706154907.422a6b73.davem@redhat.com>
References: <20040629222751.392f0a82.davem@redhat.com>
	<20040630152750.2d01ca51@dell_ss3.pdx.osdl.net>
	<20040630153049.3ca25b76.davem@redhat.com>
	<20040701133738.301b9e46@dell_ss3.pdx.osdl.net>
	<20040701140406.62dfbc2a.davem@redhat.com>
	<20040702013225.GA24707@conectiva.com.br>
	<20040706093503.GA8147@outpost.ds9a.nl>
	<20040706114741.1bf98bbe@dell_ss3.pdx.osdl.net>
	<20040706194034.GA11021@mail.shareable.org>
	<20040706131235.10b5afa8.davem@redhat.com>
	<20040706224453.GA6694@outpost.ds9a.nl>
	<20040706154907.422a6b73.davem@redhat.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not argue with that the correct thing to do is to use window scaling
and find/fix the poor sop's stuck behind busted networks.

But: isn't it better to have just one sysctl parameter set (tcp_rmem)
and set the window scale as needed rather than increasing the already
bewildering array of dials and knobs?  I can't see why it would be advantageous
to set a window scale of 7 if the largest possible window ever offered
is limited to a smaller value? 
