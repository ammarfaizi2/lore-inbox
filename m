Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVKNID1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVKNID1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 03:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVKNID1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 03:03:27 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:60562
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750731AbVKNID0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 03:03:26 -0500
Message-Id: <43785304.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 14 Nov 2005 09:04:04 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [discuss] Re: [PATCH 5/39] NLKD/x86-64 - early/late CPU
	up/down notification
References: <43720DAE.76F0.0078.0@novell.com>  <43720EAF.76F0.0078.0@novell.com>  <43720F32.76F0.0078.0@novell.com> <200511101410.16903.ak@suse.de>
In-Reply-To: <200511101410.16903.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 10.11.05 14:10:16 >>>
>On Wednesday 09 November 2005 15:01, Jan Beulich wrote:
>> x86_64-specific part of the new mechanism to allow debuggers to
learn
>> about starting/dying CPUs as early/late as possible.
>
>Please just use the normal notifier chains instead (CPU_UP, CPU_DOWN,

>register_cpu_notifier). I don't see much sense to have two different 
>mechanisms to do the same thing. While they might be not as
early/late
>as your mechanism I think the users of your debugger can tolerate
that.

Assuming you mean CPU_ONLINE and CPU_DEAD. But no, I don't really like
this. The most significant difference is that the existing notifications
are not sent on the starting CPU, but on the one it got started from.
The point in time is only the second reason for not using these.

Jan
