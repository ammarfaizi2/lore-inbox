Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271036AbTGPStN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271079AbTGPStN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:49:13 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:12817 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S271036AbTGPStB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:49:01 -0400
Message-ID: <3F15A187.3090802@enterprise.bidmc.harvard.edu>
Date: Wed, 16 Jul 2003 15:03:35 -0400
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk> <20030716171607.GM833@suse.de> <20030716172331.GD21896@suse.de> <20030716172531.GP833@suse.de> <20030716172823.GE21896@suse.de> <20030716173122.GQ833@suse.de>
In-Reply-To: <20030716173122.GQ833@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Wed, Jul 16 2003, Dave Jones wrote:
>  
>
>>Lost sync here. Mouse dancing. vmstat output stopped for a few seconds.
>>    
>>
>Doesn't look really bogged down by interrupt load, still half idle. So
>that looks like a PS2 bug. Unless the irq latencies are really bad,
>

FWIW, this also affects PPP over an async serial line (in my case to a 
56Kb modem).  During cdparanoia runs, the modem Tx/Rx lights all but 
stop as the missed packets drop retransmissions into the minute+ 
timeframe.  (Oddly, I don't recall seeing framing errors from ifconfig; 
must be the lower level ppp substrate or some such...)

I can confirm this with 2.4.20, am mostly certain it affects 2.4.21 
(will have to retest to be sure).  Similarly to Dave, I'm using an 
IDE/ATAPI burner with both DMA and UNMASKIRQ enabled.

Kris


