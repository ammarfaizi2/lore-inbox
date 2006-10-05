Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWJEXWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWJEXWw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWJEXWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:22:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:19079 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751438AbWJEXWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:22:51 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <452593AC.3000406@s5r6.in-berlin.de>
Date: Fri, 06 Oct 2006 01:22:20 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net
Subject: Re: ohci1394 regression in 2.6.19-rc1
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <200610052132.11544.s0348365@sms.ed.ac.uk> <4525842F.3040109@s5r6.in-berlin.de> <200610052337.17805.s0348365@sms.ed.ac.uk>
In-Reply-To: <200610052337.17805.s0348365@sms.ed.ac.uk>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Thursday 05 October 2006 23:16, Stefan Richter wrote:
>> ...you can then revert the 'switch to kthread' patch and see if the
>> message "Running dma failed because Node ID is not valid" disappears.
>> Would be nice if you could test that.
> 
> Of course. I tried reverting these two, and it has not helped.

Thanks.

> -rw-r--r--  1 root root 562133 2006-10-05 23:29 kernel/drivers/ieee1394/ieee1394.ko
> 
> (KBUILD only regenerated this file, I hope that's correct.)

Yes.

> http://devzero.co.uk/~alistair/ieee1394/dmesg-2.6.19-rc1-reverts.gz

One more thing you could to try if you can spare the time:

Build and boot Linux _2.6.18_ after applying this patchkit:
http://me.in-berlin.de/~s5r6/linux1394/updates/
This is only little more of 1394 stuff than what is now in 2.6.19-rc1.

This test would at least give a hint if changes sent via the linux1394
git tree are the culprit, or some change from outside.

In case you are familiar with quilt, take the quilt variant of the
patchkit instead of the collapsed patch. Short instructions on the
patchkits are on the website. The quilt patchset would allow to hunt
down the bad patch by bisection --- if the bad one is among the 1394
updates in the first place.
-- 
Stefan Richter
-=====-=-==- =-=- --==-
http://arcgraph.de/sr/
