Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVHIOwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVHIOwS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVHIOwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:52:18 -0400
Received: from berkeleydata.net ([64.62.242.226]:47289 "HELO berkeleydata.net")
	by vger.kernel.org with SMTP id S964803AbVHIOwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:52:18 -0400
Message-ID: <42F8C326.2020102@berkeleydata.net>
Date: Tue, 09 Aug 2005 08:52:22 -0600
From: Jonathan Ellis <jonathan@berkeleydata.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: datagram queue length
References: <42F8B5EC.2090204@berkeleydata.net> <Pine.LNX.4.61.0508091037180.26280@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0508091037180.26280@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
>>I seem to be running into a limit of 64 queued datagrams.  This isn't a
>>data buffer size; varying the size of the datagram makes no difference
>>in the observed queue size.  If more datagrams are sent before some are
>>read, they are silently dropped.  (By "silently," I mean, "tcpdump
>>doesn't record these as dropped packets.")

> Your datagram receiver isn't keeping up with your datagram
> transmitter. If you increase the number of datagrams that are
> being queued, you will still encounter the same problem, but
> after more datagrams are stored.

Right -- except that my consumer is quite fast enough in the average 
case; it's only the worst case where it can't keep up.  Extending the 
queue would allow it to catch up with such bursts of activity without 
dropping requests.  The low- and mid- hanging fruit has already been 
picked as far as consumer optimization goes; anything remaining is quite 
high indeed.

> In your test code, you deliberately don't receive anything
> for 5 seconds. What do you expect?

I expected to demonstrate the problem. :)

-Jonathan
