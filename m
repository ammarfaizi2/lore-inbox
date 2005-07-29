Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVG2CBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVG2CBT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 22:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVG2CBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 22:01:19 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:26525 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262010AbVG2CBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 22:01:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tcSPjvrSrAdd7ydi1Fwxa6qRwkXzxoiKp2AssHGah79hAXW9pOLMAvuP0BUwrzvKZYtlM+Hpg7qbPAu6JVbfV0gwMTkKHlLgEe78+dwHxQZaU1TnThmz7gXvLBmdNRw/o/s2CagtjBnHRqnmVQpF0mMYqsihb6QrG4BzHUdzXxc=  ;
Message-ID: <42E98DEA.9090606@yahoo.com.au>
Date: Fri, 29 Jul 2005 12:01:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
References: <200507290153.j6T1rYg03861@unix-os.sc.intel.com>
In-Reply-To: <200507290153.j6T1rYg03861@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:

>Nick Piggin wrote on Thursday, July 28, 2005 6:46 PM
>
>>I'd like to try making them less aggressive first if possible.
>>
>
>Well, that's exactly what I'm trying to do: make them not aggressive
>at all by not performing any load balance :-)  The workload gets maximum
>benefit with zero aggressiveness.
>
>

Unfortunately we can't forget about other workloads, and we're
trying to stay away from runtime tunables in the scheduler.

If we can get performance to within a couple of tenths of a percent
of the zero balancing case, then that would be preferable I think.


Send instant messages to your online friends http://au.messenger.yahoo.com 
