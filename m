Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbTKSOKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 09:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTKSOKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 09:10:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37581 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264092AbTKSOKm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 09:10:42 -0500
Message-ID: <3FBB79C4.9090304@pobox.com>
Date: Wed, 19 Nov 2003 09:10:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Madhavi <madhavis@sasken.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Switching packets from netif_rx()
References: <Pine.LNX.4.33.0311191905580.2480-100000@pcz-madhavis.sasken.com>
In-Reply-To: <Pine.LNX.4.33.0311191905580.2480-100000@pcz-madhavis.sasken.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Madhavi wrote:
> The setup is -
> 
> 	+-----------+		+------------+		+------+
> 	| Streamer  |-----------|   Switch   |----------| Host |
> 	+-----------+		+------------+		+------+
> 
> The switching functionality is implemented in function netif_rx(). Based
> on the list of outgoing interfaces, I am doing the following things.
> 
> * Cloning the packets.
> * Obtaining outgoing device from outgoing interface index.
> * Calling dev_queue_xmit() to send the packet on outgoing device.


As a tangent, this is pretty much what CONFIG_NET_FASTROUTE does...

	Jeff



