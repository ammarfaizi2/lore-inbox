Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWEII2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWEII2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWEII2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:28:31 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:40235
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751466AbWEII2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:28:31 -0400
Message-Id: <44606F07.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Tue, 09 May 2006 10:29:27 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <kristen.c.accardi@intel.com>, <pcihpd-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Pcihpd-discuss] [PATCH] correct pciehp init recovery
References: <445249FE.76E4.0078.0@novell.com> <1146245903.25490.10.camel@whizzy> <44575154.76E4.0078.0@novell.com> <20060509004958.28b2b243.akpm@osdl.org>
In-Reply-To: <20060509004958.28b2b243.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andrew Morton <akpm@osdl.org> 09.05.06 09:49 >>>
>"Jan Beulich" <jbeulich@novell.com> wrote:
>>
>> >>> Kristen Accardi <kristen.c.accardi@intel.com> 28.04.06 19:38 >>>
>> >On Fri, 2006-04-28 at 16:59 +0200, Jan Beulich wrote:
>> >> Clean up the recovery path from errors during pcie_init().
>> >> 
>> >It's possible that this driver never actually requested an irq if was in
>> >poll mode.  Then you will call free_irq, when what you really want to do
>> >is kill the timer that may have been started. 
>> 
>> Thanks for pointing this out, here's the updated patch:
>> 
>> Clean up the recovery path from errors during pcie_init().
>> 
>
>Well, it does more than clean things up.  It fixes bugs.
>
>Could we have a more accurate and complete changelog please?

Clean up (fix) the recovery path from errors during pcie_init() by properly
undoing any initialization steps already carried out.

