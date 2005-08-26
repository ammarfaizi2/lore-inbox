Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVHZOBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVHZOBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 10:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVHZOBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 10:01:42 -0400
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:12632 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S965030AbVHZOBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 10:01:42 -0400
X-SBRSScore: None
Message-ID: <430F20BF.1080703@fujitsu-siemens.com>
Date: Fri, 26 Aug 2005 16:01:35 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: yhlu <yhlu.kernel@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel>  <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com>  <20050812133248.GN8974@wotan.suse.de>  <42FCA97E.5010907@fujitsu-siemens.com>  <42FCB86C.5040509@fujitsu-siemens.com>  <20050812145725.GD922@wotan.suse.de>  <86802c44050812093774bf4816@mail.gmail.com>  <20050812164244.GC22901@wotan.suse.de> <86802c4405081210442b1bb840@mail.gmail.com> <43099FDF.6030504@fujitsu-siemens.com> <Pine.LNX.4.61L.0508231204510.2422@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0508231204510.2422@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>  Well, Intel's "Multiprocessor Specification" mandates that (see section 
> 3.6.1 and also the compliance list in Appendix C).  I does not mandate 
> local APIC IDs to be consecutive though.

Unless I am mistaken, the MP spec does not say that _CPUs_ must start 
from 0. We had an IO-APIC at 0. The MP spec says that the IDs must be 
unique (I am told this isn't true any more because an IO APIC and a CPU 
may have the same ID) and _need not_ be consecutive.

We tried different setups; one had IO APICs at 0,1,2 and CPUs starting 
at 16. I can't see that this is forbidden (the reason is that the 
IO-APICs have only 4-bit APIC ID registers). Anyway we changed it now to 
have both IO-APICs and CPUs start at 0.

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
