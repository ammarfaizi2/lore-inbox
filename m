Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265836AbUA1DUO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 22:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbUA1DUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 22:20:14 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:31688 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S265836AbUA1DUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 22:20:08 -0500
Message-ID: <40172A31.6060901@oracle.com>
Date: Wed, 28 Jan 2004 04:19:13 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@intel.com
Subject: Re: 2.6.2-rc2-bk1 oopses on boot (ACPI patch)
References: <40171B5B.4020601@oracle.com> <20040127184228.3a0b8a86.akpm@osdl.org> <Pine.LNX.4.58.0401271907070.10794@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401271907070.10794@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 27 Jan 2004, Andrew Morton wrote:
> 
>>Divide by zero.  Looks like ACPI is now passing bad values into the
>>frequency change notifier.
>>
>>Does this make the oops go away?
> 
> 
> Other values will still cause divide-by-zero (any divisor in 0..9 will do 
> it). Besides, we're dividing with _old_, not new, so that's the one we 
> should likely check.
> 
> 		Linus

Indeed... I get two of the debug printks from the patch, but in the
  end I still oops due to a div-by-zero with EIP in time_cpufreq_notifier.

I'll try and look into Linus' suggestion about printing out stuff from
  adjust_jiffies() in cpufreq.c and will report later.


Thanks,

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

