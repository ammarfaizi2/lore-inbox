Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbWECPcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbWECPcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWECPcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:32:09 -0400
Received: from citi.umich.edu ([141.211.133.111]:5996 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S965223AbWECPcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:32:06 -0400
Message-ID: <4458CD09.4010709@citi.umich.edu>
Date: Wed, 03 May 2006 11:32:25 -0400
From: Chuck Lever <cel@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Organization: Center for Information Technology Integration
User-Agent: Thunderbird 1.5.0.2 (Macintosh/20060308)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc3 PCI init hang
References: <44565BB9.8020504@citi.umich.edu> <20060503054149.aae472dd.akpm@osdl.org>
In-Reply-To: <20060503054149.aae472dd.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 01 May 2006 15:04:25 -0400
> Chuck Lever <cel@citi.umich.edu> wrote:
> 
>> I have a dual Pentium III I use for testing.  Since late last week 
>> (around about 2.6.17-rc3) it hangs during boot just after "Setting up 
>> standard PCI resources".  2.6.17-rc2 works fine.
> 
> Bummer

Strange (but different) behavior also seen on a PE2650.

>> A push in the right direction would be appreciated.  Please reply off 
>> list as I'm not subscribed.
>>
> 
> Is there any chance you can do a git-bisect to find the bad patch?

Done.  The bad patch was Badari's first vectored I/O patch.  Removing 
the patch fixes the badness on both systems.  I reported this to Badari 
late yesterday afternoon.

He hasn't seen this behavior in his test environment, which is only 
ppc64 and amd64.

-- 
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>
