Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265699AbUATUPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbUATUPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:15:15 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:6289 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265699AbUATUPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:15:10 -0500
Message-ID: <400D8BBF.7070005@sgi.com>
Date: Tue, 20 Jan 2004 14:12:47 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix updates
References: <200401152154.i0FLscIG023452@fsgi900.americas.sgi.com> <20040116144132.A24555@infradead.org> <400D6A5B.7090009@sgi.com> <20040120180851.A18872@infradead.org>
In-Reply-To: <20040120180851.A18872@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Tue, Jan 20, 2004 at 11:50:19AM -0600, Patrick Gefre wrote:
>  
>
>>Yes this probably looks a little odd. This was setup this way for TIO. 
>>The macro in the TIO code checks to see
>>if it is a 'soft' struct or bridge address AND what bridge type it is - 
>>accessing different registers depending
>>on TIO or not TIO (the 2 cases we have so far). We think this makes the 
>>register access functions pretty flexible/generic.
>>    
>>
>
>Sorry, but this is completly bogus.  Just declare one accessor per
>datatype.
>  
>

Guess I don't understand your point. Do you want us to create separate 
functions for soft-struct and bridge address
and TIO and non-TIO - 4 functions for each register access, rather than 1 ?

That seems to add a lot of extra code now and we'll need to add new 
functions as we add more ASIC interfaces - which is exactly
what we are trying to avoid. The way we have it, if we add a new ASIC we 
just need to make the lowest level functions ASIC-aware
and then we are done - no need to have blocks of if-then-else code in 
the mainline to determine which function to call.


