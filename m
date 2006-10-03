Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965255AbWJCFcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965255AbWJCFcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 01:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbWJCFcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 01:32:15 -0400
Received: from sandeen.net ([209.173.210.139]:1848 "EHLO sandeen.net")
	by vger.kernel.org with ESMTP id S965255AbWJCFcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 01:32:14 -0400
Message-ID: <4521F5DE.7070302@sandeen.net>
Date: Tue, 03 Oct 2006 00:32:14 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-1.2689.fc6PAE: oops in ext3_clear_inode+0x52/0x8b
References: <451C33B2.5000007@goop.org> <20060928142313.8848cec9.akpm@osdl.org>
In-Reply-To: <20060928142313.8848cec9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 28 Sep 2006 13:42:26 -0700
> Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
>> I just filed this in the Redhat bugzilla, since its from the FC6 distro 
>> kernel.  But since its fairly close to current kernel.org kernels, I 
>> thought it might be relevent.
>>
>> The bug is https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208488
>>
>> Unfortunately this isn't a very useful report since it was a once-off, 
>> and there's a P-tainting module in there.  But if anyone sees anything 
>> else like this, it's interesting.
>>
>> The oops is:
>>
>> BUG: unable to handle kernel paging request at virtual address 756e6547
> 
> 756e6547 -> uneG.   Matches "GenuineIntel".
> 
> That'll get written into a temporary page by the /proc/cpuinfo handler, so
> it might just be a use-uninitialised.

But strangely enough, it's the second report we've seen with this exact 
backtrace, and the same "Genu" ascii string where the i_default_acl should be.

Both boxes had been through a suspend-to-ram recently, just in case that might 
matter.

Seems like something more than random chance...

-Eric
