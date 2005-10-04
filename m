Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVJDL6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVJDL6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 07:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVJDL6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 07:58:47 -0400
Received: from mail.dvmed.net ([216.237.124.58]:61862 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932378AbVJDL6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 07:58:45 -0400
Message-ID: <43426E6F.60500@pobox.com>
Date: Tue, 04 Oct 2005 07:58:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       bonding-devel@lists.sourceforge.net, ctindel@users.sourceforge.net,
       fubar@us.ibm.com
Subject: Re: [patch 2.6.14-rc2] bonding: replicate IGMP traffic in activebackup
 mode
References: <09282005175053.11150@bilbo.tuxdriver.com>
In-Reply-To: <09282005175053.11150@bilbo.tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Replicate IGMP frames across all slaves in activebackup mode. This
> ensures fail-over is rapid for multicast traffic as well. Otherwise,
> multicast traffic will be lost until the next IGMP membership report
> poll timeout.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> ---
> This is conceptually similar to the treatment of IGMP traffic in
> bond_alb_xmit. In that case, IGMP traffic transmitted on any slave
> is re-routed to the active slave in order to ensure that multicast
> traffic continues to be directed to the active receiver.
> 
>  drivers/net/bonding/bond_main.c |   53 ++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 51 insertions(+), 2 deletions(-)

Applied.  For future patches, please

* don't include description following the signed-off-by line

* if you are willing to special-case me, I actually don't like seeing a 
diffstat; I have to manually remove it before applying


