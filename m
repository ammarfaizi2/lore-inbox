Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVFMKCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVFMKCs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 06:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVFMKCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 06:02:46 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:44633 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261451AbVFMKC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 06:02:27 -0400
Message-ID: <42AD59A9.3030404@yahoo.com.au>
Date: Mon, 13 Jun 2005 20:02:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] blkstat
References: <42AD55FA.50109@yahoo.com.au> <200506131954.45361.kernel@kolivas.org>
In-Reply-To: <200506131954.45361.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Mon, 13 Jun 2005 19:46, Nick Piggin wrote:

>>Oh, and before I go further, does anyone know of any program
>>or statistic that allows the same functionality? Any comments?
> 
> 
> Would something like iostat give similar results?
> 

The problem with that is that it does not give you a % idle
figure on the block device, so you basically can't see if
the device is becoming a bottleneck.

You can kind of guess if you take into account the seeks,
and the throughput, but you're still missing things like
head position (eg. changes throughput), settle time and
rotational latency, and lots of other stuff.

Thanks,
Nick

Also, BTW. the way I have done the kernel patch make a
device show 100% utilisation even if it is not doing anything
but waiting for a plug, or an anticipatory scheduler. This
is basically all the end user wants to know, although for
development purposes it may be interesting to know the other
metric too.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
