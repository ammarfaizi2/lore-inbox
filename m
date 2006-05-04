Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWEDVWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWEDVWG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWEDVWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:22:05 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:8575 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750804AbWEDVWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:22:04 -0400
Message-ID: <445A7059.7000202@cfl.rr.com>
Date: Thu, 04 May 2006 17:21:29 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Roy Rietveld <rwm_rietveld@hotmail.com>
CC: linux-os@analogic.com, linux-kernel@vger.kernel.org
Subject: Re: TCP/IP send, sendfile, RAW
References: <BAY105-F38F372575F5B72AF1DACE6E9B40@phx.gbl>
In-Reply-To: <BAY105-F38F372575F5B72AF1DACE6E9B40@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 May 2006 21:22:19.0725 (UTC) FILETIME=[D35ED7D0:01C66FC0]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14426.000
X-TM-AS-Result: No--0.400000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Rietveld wrote:
> I read something about zero copy may i need somelike that.

Yes, zero copy IO does make a huge difference.  Unfortunately, at this 
time, it is not possible to do zero copy IO on sockets save for 
sendfile() because they do not yet support aio, at least, not the last 
time I checked.

For comparison I wrote an ftp server for NT 4.0 several years ago on a 
PII-233 system ( similar speed to yours ) and saw similar results to 
yours until switching to zero copy IO, which pushed 11,820 KB/s ftp 
transfers using less than 1% of the cpu.

I'm still waiting for Linux to be able to do this, and hopefully won't 
have to wait much longer.

