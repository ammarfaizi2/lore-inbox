Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266908AbUBRXTU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266817AbUBRXTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:19:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3501 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266908AbUBRXST
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:18:19 -0500
Message-ID: <4033F2A7.70404@pobox.com>
Date: Wed, 18 Feb 2004 18:17:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: root@chaos.analogic.com,
       =?ISO-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: [NET] 64 bit byte counter for 2.6.3
References: <1077123078.9223.7.camel@midux>	<20040218101711.25dda791@dell_ss3.pdx.osdl.net>	<Pine.LNX.4.53.0402181527000.7318@chaos>	<1077137014.18843.10.camel@midux>	<Pine.LNX.4.53.0402181645220.27707@chaos> <20040218145740.6b47c218@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040218145740.6b47c218@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> Do it right:
> 	* use per-cpu long long for both bytes and packet counts
> 	  and change each driver ...
> 	* expose both a new 64 bit and legacy 32 bit /proc interface
> 	* no tools use /sys yet, so that needs to show long long
> 	* have both a get_stats and get_stats64 hook in netdevice so not all drivers
> 	  have to be converted at once.


Yep.

	Jeff



