Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVFJCNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVFJCNz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 22:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVFJCNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 22:13:55 -0400
Received: from mail.dvmed.net ([216.237.124.58]:63448 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261435AbVFJCNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 22:13:54 -0400
Message-ID: <42A8F758.2060008@pobox.com>
Date: Thu, 09 Jun 2005 22:13:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Ketrenos <jketreno@linux.intel.com>
CC: "David S. Miller" <davem@davemloft.net>, pavel@ucw.cz, vda@ilport.com.ua,
       abonilla@linuxwireless.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
References: <200506090909.55889.vda@ilport.com.ua>	<20050608.231657.59660080.davem@davemloft.net>	<20050609104205.GD3169@elf.ucw.cz> <20050609.125324.88476545.davem@davemloft.net> <42A8AE2A.4080104@linux.intel.com>
In-Reply-To: <42A8AE2A.4080104@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Ketrenos wrote:
> I don't know if all the distributions have moved away from this model. 
> If they have and the devices are brought up regardless of link, then
> going back to delaying radio initialization until the open() is called
> is workable. 


When the interface is not up, we ideally want the device to be as 
passive as possible.

Most net drivers shut down as much as possible at dev->close() time, and 
it would really be good if wireless drivers followed suit.

	Jeff


