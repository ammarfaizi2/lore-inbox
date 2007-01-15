Return-Path: <linux-kernel-owner+w=401wt.eu-S1750773AbXAOOb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXAOOb4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 09:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbXAOOb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 09:31:56 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:16494 "EHLO
	pd2mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXAOObz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 09:31:55 -0500
Date: Mon, 15 Jan 2007 08:28:50 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH -mm] sata_nv: cleanup ADMA error handling
In-reply-to: <45AAE981.60906@shaw.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Cc: Jeff Garzik <jeff@garzik.org>, Allen Martin <AMartin@nvidia.com>
Message-id: <45AB8FA2.50909@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <45AAE981.60906@shaw.ca>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> -In the error_handler function the code would always go through and do 
> an ADMA channel reset and also dump out the state of all the CPBs. This 
> reset seems heinous in this situation since we haven't even decided to 
> reset anything yet. The output seems redundant at this point since 
> libata already dumps the state of all active commands on errors (and it 
> also triggers at times when it shouldn't, like when suspending). Do the 
> ADMA reset only on hardreset and remove the output.

Actually, upon further thought some of this stuff really should be done 
in the error_handler method, just maybe not the channel reset. I'll cut 
another patch shortly.
