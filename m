Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWHRTHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWHRTHL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 15:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWHRTHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 15:07:11 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:36795
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932235AbWHRTHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 15:07:09 -0400
Message-ID: <44E60FD3.7040003@microgate.com>
Date: Fri, 18 Aug 2006 14:06:59 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial issue
References: <1155862076.24907.5.camel@mindpipe> <1155915851.3426.4.camel@amdx2.microgate.com> <1155923734.2924.16.camel@mindpipe> <44E602C8.3030805@microgate.com> <1155925024.2924.22.camel@mindpipe> <20060818183609.GE21101@flint.arm.linux.org.uk> <1155926405.2924.25.camel@mindpipe> <20060818185209.GF21101@flint.arm.linux.org.uk>
In-Reply-To: <20060818185209.GF21101@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Aug 18, 2006 at 02:40:05PM -0400, Lee Revell wrote:
> 
>>On Fri, 2006-08-18 at 19:36 +0100, Russell King wrote:
>>
>>>On Fri, Aug 18, 2006 at 02:17:04PM -0400, Lee Revell wrote:
>>>Are you transferring from or two the machine which is having a problem?
>>>IOW, is the problem machine doing lots of receive or lots of transmit?
>>>
>>
>>Neither uploads nor downloads work in interrupt mode.  Both work in
>>polled mode.
> 
> 
> Ho hum.  This probably requires the use of a serial splitter so that
> an independent known good machine can monitor what's being sent by
> each end.

Since you have 2 serial ports, can you test
using ttyS1 as the console (kernel boot parameter console=ttyS1)
and do a transfer on ttyS0 (interrupt mode) with a separate
connection to another machine?

This at least removes interaction with the console
from the picture.

-- 
Paul Fulghum
Microgate Systems, Ltd.
