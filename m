Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbVIIIwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVIIIwU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVIIIwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:52:19 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:27915
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965101AbVIIIwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:52:17 -0400
Message-Id: <432169A3020000780002482E@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 10:53:23 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <zwane@arm.linux.org.uk>, "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [discuss] [PATCH] fix x86-64 condition to call
	nmi_watchdog_tick
References: <43207ED00200007800024566@emea1-mh.id2.novell.com> <200509091043.01659.ak@suse.de>
In-Reply-To: <200509091043.01659.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 09.09.05 10:43:01 >>>
>On Thursday 08 September 2005 18:11, Jan Beulich wrote:
>> (Note: Patch also attached because the inline version is certain to
get
>> line wrapped.)
>>
>> Don't call nmi_watchdog_tick() when this isn't enabled.
>
>Hmm, I think i will concur with Zwane's objection to this for now.

And I understand the concerns. Nevertheless, the code right now, on
properly working systems and with the watchdog enabled (but not active)
results in bad NMIs to be supressed (because the code returns right
after calling nmi_watchdog_tick). I'd think that on systems as Zwane
describes one should simply not enable the watchdog (and for this reason
I continue to believe that like on i386 the default should be to have no
watchdog).

Jan
