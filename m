Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265276AbUFHSDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUFHSDa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 14:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUFHSDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 14:03:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37607 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265275AbUFHSDW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 14:03:22 -0400
Message-ID: <40C5FF43.1090805@pobox.com>
Date: Tue, 08 Jun 2004 14:02:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, Netdev <netdev@oss.sgi.com>
Subject: Re: PATCH: ethtool power manglement hooks
References: <20040607155018.GA5810@devserv.devel.redhat.com>
In-Reply-To: <20040607155018.GA5810@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Several ethernet drivers have been broken by the ethtool support because
> the ioctl code used to power the interface up and down as needed. Rather


To be more specific, the new ethtool_ops feature bypasses code in net 
drivers which did one of two things:
* power up the hardware, perform the ioctl, and power down the hardware
	or
* fail if netif_running() is false, indicating the driver's requirement 
that MII and ethtool operations only occur when the interface is up 
(thereby ignoring the power management issues)


Also, CC net driver patches to me and netdev, pretty please with sugar 
on it.

	Jeff


