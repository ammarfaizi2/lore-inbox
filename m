Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbUABDxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 22:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbUABDxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 22:53:09 -0500
Received: from simmts5.bellnexxia.net ([206.47.199.163]:17073 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261953AbUABDxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 22:53:06 -0500
Message-ID: <3FF4EB54.7060809@sympatico.ca>
Date: Fri, 02 Jan 2004 03:53:56 +0000
From: Tyler Hall <tyler_hall@sympatico.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rpc@cafe4111.org
CC: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
References: <18Cz7-7Ep-7@gated-at.bofh.it> <20040101001549.GA17401@win.tue.nl> <1072917113.11003.34.camel@fur> <200401011814.22415.rpc@cafe4111.org>
In-Reply-To: <200401011814.22415.rpc@cafe4111.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're moving toward treating device numbers as unique handles for 
devices in a system, why can't we just dynamically allocate them like 
process ID's? As each device driver loads and registers with the kernel, 
it can request a device number and the kernel can assign the next 
available one.

Tyler

Rob wrote:

>On Wednesday 31 December 2003 07:31 pm, Rob Love wrote:
>
><snip>
>  
>
>>This is definitely an interesting problem space.
>>
>>I agree wrt just inventing consecutive numbers.  If there was a nice way
>>to trivially generate a random and unique number from some
>>device-inherent information, that would be nice.
>>
>>	Rob Love
>>    
>>
>
>my first thought was hardware serial numbers, but i'm guessing they mostly 
>don't exist based on the discomfort caused by the pentium 3 serial number in 
>the past. my second thought was raw latency. in the real world, 2 identical 
>devices of any nature are going to respond electrically at different rates. i 
>kind of stole the concept from what i read about the i810 rng... quantum 
>differences can distinguish between 2 of anything, and based on the response 
>time, 'cookies' can be written out to keep them separately ID'd. some devices 
>will get slower over time, e.g. increasing error rates and aging silicon will 
>throw the 'cookie' off, so you'd re-calibrate every so often, like on a 
>reboot. those are rare for some of us ;)
>
>the big IF: can you measure that with enough precision to at least decrease 
>the probablity of collision? 
>
>  
>

