Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWGNIdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWGNIdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 04:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWGNIdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 04:33:40 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:23056 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S964808AbWGNIdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 04:33:39 -0400
Message-ID: <44B756AB.50102@shadowen.org>
Date: Fri, 14 Jul 2006 09:32:43 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mbligh@google.com, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.18-rc1-git4 and 2.6.18-rc1-mm1 OOM's on boot
References: <44B528F4.6080409@google.com>	<20060712181636.d7cbbb99.akpm@osdl.org>	<44B5A0DD.9070200@google.com>	<44B654EA.3030301@shadowen.org>	<44B74F24.2060209@shadowen.org> <20060714010858.d6824f1f.akpm@osdl.org>
In-Reply-To: <20060714010858.d6824f1f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 14 Jul 2006 09:00:36 +0100
> Andy Whitcroft <apw@shadowen.org> wrote:
> 
>>> Yep, I've run this with badari's fix as a set across the whole family. I 
>>> did all dbenchall runs for now as this example is showing on that and 
>>> badari's is triggered same.  If there is any measure of success there 
>>> I'll throw in the externals too.
>> General goodness from this one.  Except where we're getting issues with 
>> the e1000's.  That seems to be fixed up by backing out some driver changes.
>>
>> All moot, as -mm2 is showing similar goodness.
> 
> Is -mm2's e1000 OK?

Whilst calling it the e1000 problem (that was how it was originally 
reported) I should say that this was related to the sysfs change in the 
following patches:

     gregkh-driver-network-class_device-to-device.patch
     gregkh-driver-class_device_rename-remove.patch

I have two boxes under test which were failing on -mm1 similar to teh 
following (from userland):

     eth-id-00:02:55:d3:37:4a            No interface found

Both are booting -mm2 fine.

I can only see two outstanding issues.  An IDE lost interrupt issue on a 
blade we have under test which I believe benh is looking at, and what 
looks like an s390 tool chain issue which I am told is being looked at.

-apw
