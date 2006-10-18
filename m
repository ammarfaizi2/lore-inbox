Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWJRPH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWJRPH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWJRPH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:07:29 -0400
Received: from smtp1.enomia.com ([64.128.160.11]:35638 "EHLO smtp1.enomia.com")
	by vger.kernel.org with ESMTP id S1161123AbWJRPH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:07:28 -0400
Message-ID: <45364317.7020908@uplogix.com>
Date: Wed, 18 Oct 2006 10:07:03 -0500
From: Paul B Schroeder <pschroeder@uplogix.com>
Reply-To: pschroeder@uplogix.com
Organization: Uplogix, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Exar quad port serial
References: <1160068402.29393.7.camel@rupert> <20061005173628.GB30993@csclub.uwaterloo.ca> <45357CA1.80706@uplogix.com> <20061018133430.GU30991@csclub.uwaterloo.ca>
In-Reply-To: <20061018133430.GU30991@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-CTCH-ID: _16B2DEF3-E0AE-415C-85D2-641185C139C9_
X-CTCH-RefID: str=0001.0A090209.453642AF.0094,ss=1,fgs=0
X-CTCH-Action: Ignore
X-OriginalArrivalTime: 18 Oct 2006 15:07:06.0027 (UTC) FILETIME=[132567B0:01C6F2C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lennart Sorensen wrote:
> On Tue, Oct 17, 2006 at 08:00:17PM -0500, Paul B Schroeder wrote:
>> Sorry for the late response..  Here is a fuller explanation.  Maybe 
>> somebody out there has a better solution:
>>
>> This is on our "Envoy" boxes which we have, according to the documentation, 
>> an "Exar ST16C554/554D Quad UART with 16-byte Fifo's".  The box also has 
>> two other "on-board" serial ports and a modem chip.
>>
>> The two on-board serial UARTs were being detected along with the first two 
>> Exar UARTs.  The last two Exar UARTs were not showing up and neither was 
>> the modem.
>>
>> This patch was the only way I could the kernel to see beyond the standard 
>> four serial ports and get all four of the Exar UARTs to show up.
>>
>> I hope this explains it well enough..
> 
> I suspect all you have to do might be to change how many ports it looks
> for.  The default max ports is 4 I believe on many kernel versions.
> 
> Look for CONFIG_SERIAL_8250_NR_UARTS and
> CONFIG_SERIAL_8250_RUNTIME_UARTS in the kernel config.
> 
Yea..  I tried that..  It had no effect..

> If that doesn't work and you do need a special driver, at least label it
> with more detail like 'for exar st16c554 quad uart' or 'for envoy board'
> or whatever makes it clear which hardware it is for.  I use exar pci
> uarts (exar XR17d15[248] chips) which work fine already with the 8250
> driver, or optionally with the jsm driver with a small change to the
> list if pci identifiers.  THey of course would not work with your driver
> since they are completely different exar chips (even though one is also
> a quad uart, although 64byte fifo).
In that case, I will redo the patch with better labeling..

Thanks...Paul...



-- 
---

Paul B Schroeder <pschroeder "at" uplogix "dot" com>
Senior Software Engineer
Uplogix, Inc. (http://www.uplogix.com/)

