Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVHFUrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVHFUrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 16:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVHFUrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 16:47:09 -0400
Received: from p54A0BC0C.dip0.t-ipconnect.de ([84.160.188.12]:60923 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261151AbVHFUrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 16:47:07 -0400
Message-ID: <42F521BD.9020607@trash.net>
Date: Sat, 06 Aug 2005 22:46:53 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: James.Bottomley@SteelEye.com, itn780@yahoo.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [ANNOUNCE 0/7] Open-iSCSI/Linux-iSCSI-5 High-Performance Initiator
References: <1122744762.5055.10.camel@mulgrave>	<20050730.125312.78734701.davem@davemloft.net>	<1122755000.5055.31.camel@mulgrave> <20050730.173453.130210989.davem@davemloft.net>
In-Reply-To: <20050730.173453.130210989.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: James Bottomley <James.Bottomley@SteelEye.com>
> Date: Sat, 30 Jul 2005 15:23:20 -0500
> 
>>Actually, I saw this and increased MAX_LINKS as well.
> 
> That does absolutely nothing, you cannot create sockets
> with protocol numbers larger than NPROTOS which like MAX_LINKS
> has the value 32.  And NPROTOS is something we cannot change.

I couldn't find any relationship between MAX_LINKS and NPROTO. NPROTO is
the maximum number of protocol families, the only limitation for
MAX_LINKS seems to be the size of sk_protocol which is an unsigned char.
So I think we can safely increase it.
