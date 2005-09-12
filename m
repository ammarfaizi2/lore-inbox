Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVILHDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVILHDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVILHDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:03:25 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:27841
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751188AbVILHDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:03:24 -0400
Message-Id: <4325448C0200007800024DF5@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 12 Sep 2005 09:04:12 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Richard Henderson" <rth@twiddle.net>
Cc: "Tom Rini" <trini@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 CFI annotations
References: <432070850200007800024465@emea1-mh.id2.novell.com>  <20050908154645.GN3966@smtp.west.cox.net>  <43207BA30200007800024502@emea1-mh.id2.novell.com>  <20050908161334.GP3966@smtp.west.cox.net>  <43214D2D02000078000247B5@emea1-mh.id2.novell.com> <20050910055836.GA28662@twiddle.net>
In-Reply-To: <20050910055836.GA28662@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Richard Henderson <rth@twiddle.net> 10.09.05 07:58:36 >>>
>On Fri, Sep 09, 2005 at 08:51:57AM +0200, Jan Beulich wrote:
>> >>> Tom Rini <trini@kernel.crashing.org> 08.09.05 18:13:34 >>>
>> >On Thu, Sep 08, 2005 at 05:57:55PM +0200, Jan Beulich wrote:
>> >
>> >> >> +	CFI_ADJUST_CFA_OFFSET 4;\
>> >> >> +	/*CFI_REL_OFFSET es, 0;*/\
>> >> >>  	pushl %ds; \
>> >> >> +	CFI_ADJUST_CFA_OFFSET 4;\
>> >> >> +	/*CFI_REL_OFFSET ds, 0;*/\
>> >> >
>> >> >Adding new commented out code never wins new friends. :)
>> >> 
>> >> I know. But how would you indicate functionality belonging there
>> but
>> >> just not provided by the translating utilities. If that's really
a
>> >> problem, then I would need to teach the respective macros to
ignore
>> >> certain operands.
>> >
>> >Not provided by binutils or ?
>> 
>> Not provided for even by the spec; if it was just binutils missing
them
>> I'd have added this already.
>
>You know this is just convention, right?  And that binutils allows
>you to put any column numbers you like?  So all you have to do it
>match whatever debugger you're planning to use.  Make something up.

I know. But I don't like the idea of 'putting something in' that later
might turn out incompatible with something else. The minimum support
from the Dwarf spec I'd expect here would be an equivalent to IA64's
.unwabi. But truly I think the processor-specific pieces of Dwarf's
frame unwind spec should provide numbering for the complete set of
registers.

Jan
