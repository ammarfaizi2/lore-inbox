Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUAAXOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUAAXOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:14:43 -0500
Received: from ms-smtp-03-smtplb.ohiordc.rr.com ([65.24.5.137]:64189 "EHLO
	ms-smtp-03-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S261898AbUAAXOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 18:14:41 -0500
From: Rob <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Date: Thu, 1 Jan 2004 18:14:22 -0500
User-Agent: KMail/1.5.4
References: <18Cz7-7Ep-7@gated-at.bofh.it> <20040101001549.GA17401@win.tue.nl> <1072917113.11003.34.camel@fur>
In-Reply-To: <1072917113.11003.34.camel@fur>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401011814.22415.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 December 2003 07:31 pm, Rob Love wrote:

<snip>
> This is definitely an interesting problem space.
>
> I agree wrt just inventing consecutive numbers.  If there was a nice way
> to trivially generate a random and unique number from some
> device-inherent information, that would be nice.
>
> 	Rob Love

my first thought was hardware serial numbers, but i'm guessing they mostly 
don't exist based on the discomfort caused by the pentium 3 serial number in 
the past. my second thought was raw latency. in the real world, 2 identical 
devices of any nature are going to respond electrically at different rates. i 
kind of stole the concept from what i read about the i810 rng... quantum 
differences can distinguish between 2 of anything, and based on the response 
time, 'cookies' can be written out to keep them separately ID'd. some devices 
will get slower over time, e.g. increasing error rates and aging silicon will 
throw the 'cookie' off, so you'd re-calibrate every so often, like on a 
reboot. those are rare for some of us ;)

the big IF: can you measure that with enough precision to at least decrease 
the probablity of collision? 

-- 
Rob Couto
rpc@cafe4111.org
Rules for computing success:
1) Attitude is no substitute for competence.
2) Ease of use is no substitute for power.
3) Safety matters; use a static-free hammer.
--

