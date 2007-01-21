Return-Path: <linux-kernel-owner+w=401wt.eu-S1751229AbXAUGjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbXAUGjZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 01:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbXAUGjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 01:39:25 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:40810 "EHLO
	pd3mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbXAUGjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 01:39:24 -0500
Date: Sun, 21 Jan 2007 00:39:20 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
In-reply-to: <20070121045437.GA7387@atjola.homenet>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>,
       Chr <chunkeey@web.de>, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com
Message-id: <45B30A98.3030206@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no>
 <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca>
 <200701202332.58719.chunkeey@web.de> <45B2C6E1.9000901@shaw.ca>
 <45B2DF43.8080304@garzik.org> <20070121045437.GA7387@atjola.homenet>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Steinbrink wrote:
> On 2007.01.20 22:34:27 -0500, Jeff Garzik wrote:
>> Robert Hancock wrote:
>>> change in 2.6.20-rc is either causing or triggering this problem. It 
>>> would be useful if you could try git bisect between 2.6.19 and 
>>> 2.6.20-rc5, keeping the latest sata_nv.c each time, and see if that 
>>
>> Yes, 'git bisect' would be the next step in figuring out this puzzle.
>>
>> Anybody up for it?
> 
> I'll go for it, but could I get an explanation how that could lead to a
> different result than my last bisection? I see the difference of keeping
> sata_nv.c but my brain can't wrap around it right now (woke up in the
> middle of the night and still not up to speed...).

Whatever the problem is, only seems to show up when ADMA is enabled, and 
so the patch that added ADMA support shows up as the culprit from your 
git bisect. However, from what Chr is reporting, 2.6.19 with the ADMA 
support added in doesn't seem to have the problem, so presumably 
something else that changed in the 2.6.20-rc series is triggering it. 
Doing a bisect while keeping the driver code itself the same will 
hopefully identify what that change is..
