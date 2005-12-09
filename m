Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVLIMlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVLIMlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 07:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVLIMlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 07:41:14 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:52368
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751219AbVLIMlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 07:41:14 -0500
Message-Id: <439989A7.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Dec 2005 13:41:59 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Rafael Wysocki" <rjw@sisk.pl>
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume
	from disk)
References: <20051204232153.258cd554.akpm@osdl.org>  <200512082335.50417.rjw@sisk.pl>  <43995957.76F0.0078.0@novell.com> <200512091220.06060.rjw@sisk.pl>
In-Reply-To: <200512091220.06060.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> "Rafael J. Wysocki" <rjw@sisk.pl> 09.12.05 12:20:05 >>>
>On Friday, 9 December 2005 10:15, Jan Beulich wrote:
>> It's a possible way to address this, but I'd rather just set a flag
>> indicating that the last-whatever values should not be considered
(to
>> get into a state just like after initial boot). Jan
>
>OK, but what is the interrupt handler supposed to do if the
>vxtime.last* values are invalid?  I guess assume delta = 0?

As I said, the state should be (re)set to whatever is in effect at
boot.

>BTW, in the interrupt handler there is:
>
>		__asm__("mulq %1\n\t"
>		        "shrdq $32, %%rdx, %0"
>		        : "+a" (delta)
>		        : "rm" (vxtime.tsc_quot)
>		        : "rdx");
>
>Is the "+a" a typo?

Why would you think so?

Jan
