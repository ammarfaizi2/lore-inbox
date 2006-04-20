Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWDTJkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWDTJkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWDTJkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:40:37 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:14425
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750796AbWDTJkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:40:36 -0400
Message-Id: <4447734F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Thu, 20 Apr 2006 11:41:03 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Martin Bligh" <mbligh@mbligh.org>, "Andrew Morton" <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc1-mm3 dies in LTP on amd64
References: <44451AD5.9070709@mbligh.org> <200604181911.13012.ak@suse.de>
In-Reply-To: <200604181911.13012.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Not very useful.  Something double faulted, but it's not on the stack
>[I wonder if the stack walker over double faults is broken. Jan - did you
>ever test that after you redid the walker?]

Maybe not specifically for a double fault, but I'm certain I checked it for some of the IST ones; looking at the code I
also can't see anyting obviously wrong. But clearly, a double fault has its most likely reason being a bad kernel stack
pointer prior to a page (or other) fault. It would therefore be necessary to know the value of the stack pointer as
retrieved from the double fault stack, which with the current display logic is not possible.

Jan
