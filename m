Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVALXZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVALXZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVALXXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:23:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1159 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261567AbVALXTe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:19:34 -0500
Message-ID: <41E5B077.8030300@pobox.com>
Date: Wed, 12 Jan 2005 18:19:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Max Krasnyansky <maxk@qualcomm.com>
CC: davem@davemloft.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK] TUN/TAP driver update and fixes for 2.6.BK
References: <41E5A5DA.1010301@qualcomm.com>
In-Reply-To: <41E5A5DA.1010301@qualcomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Krasnyansky wrote:
> Dave, Andrew,
> 
> Could one of you please pull TUN/TAP driver updates from my tree
>         bk://maxk.bkbits.net/tun-2.6
> 
> This will update the following files:
> 
>  drivers/net/Kconfig    |    1
>  drivers/net/tun.c      |  145 
> ++++++++++++++++++++++++++++++++++++++++++-------
>  include/linux/if_tun.h |    2
>  3 files changed, 128 insertions(+), 20 deletions(-)


Non-technical comments:

1) Please send drivers/net patches to me and netdev@oss.sgi.com

2) Consider using the bk-make-sum script (in Documentation/BK-usage/) to 
generate your summary.  This will add a "bk pull " prefix to your BK url 
particularly, making it even easier to cut-n-paste.

3) Please include a patch in your submission so that list readers may 
review your changes, not just the BK users.


Technical comments:

1) Accepted, I pulled it into my netdev-2.6 queue

2) in your implementation of tun_get_drvinfo(), it may be nice to 
include the tun/tap interface number in info->bus_info, to differentiate 
between multiple tun interfaces or multiple tap interfaces.

3) You might consider moving tun_set_msglevel() completely inside 
TUN_DEBUG ifdef.

4) use of MODULE_VERSION() is recommended


