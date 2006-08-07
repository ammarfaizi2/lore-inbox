Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWHGOuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWHGOuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWHGOuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:50:04 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:3399
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750842AbWHGOuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:50:02 -0400
Message-Id: <44D76F60.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 07 Aug 2006 15:50:40 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <anil.s.keshavamurthy@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: notify_page_fault_chain
References: <44D75ACE.76E4.0078.0@novell.com>
 <200608071536.40303.ak@suse.de>
In-Reply-To: <200608071536.40303.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I consider it already questionable to split out a specific  
>> fault from the general die notification (previous users of the functionality all of the sudden won't get
notifications
>> for one of the most crucial faults anymore), but entirely hiding the functionality (unavailable without
CONFIG_KPROBES,
>> and even with it not getting exported) is really odd.
>
>You want to use it for your debugger? 

Yes, in its "light" form (i.e. without exception handling framework changes) it has to rely on this infrastructure.

Jan
