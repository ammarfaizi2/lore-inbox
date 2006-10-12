Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030704AbWJLKXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030704AbWJLKXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 06:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161536AbWJLKXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 06:23:24 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:23567 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030704AbWJLKXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 06:23:23 -0400
Message-ID: <452E1777.6070000@shadowen.org>
Date: Thu, 12 Oct 2006 11:22:47 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Martin J. Bligh" <mbligh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
References: <20061010000928.9d2d519a.akpm@osdl.org>	<452D4D17.1090705@google.com> <20061011144713.cb0c1453.akpm@osdl.org>
In-Reply-To: <20061011144713.cb0c1453.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 11 Oct 2006 12:59:19 -0700
> "Martin J. Bligh" <mbligh@google.com> wrote:
> 
>> Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
>>>
>>>
>>> -
>>>   
>> Oh, and hangs in LTP.
>>
>> x86_64 just hangs.
>> http://test.kernel.org/abat/54544/debug/test.log.1 (in something io-ish)
>>
> 
> What makes you thing it was something io-ish?
> 
>> http://test.kernel.org/abat/54541/debug/test.log.1 (ppc64)
>> craps itself with
> 
> There's been a fix for this in hot-fixes/ for 24 hours.  It'd be good if you
> could tinkle the scripts to pull that directory in.
> 
> Or just suck the -mm git tree.  That incorprates additions to hot-fixes/ within
> five minutes.

I have to say I always forget its there, debug and fix it only to find
its in hotfixes, grr.  So having the test system notice and fire new
jobs off with these too is the Right Thing (tm).

I've hopefully modified the test system to take hot-fixes into account.
  I do wonder if there should be a series file in this directory, as we
have no ordering otherwise and it would simplify the detection and
application of these patches at my end for sure.

Anyhow, hopefully we'll get some results in the next 4 hours out to TKO
and see how it looks ... assuming they don't all go "what patch, boom,
crash".

-apw

