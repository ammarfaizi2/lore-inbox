Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265633AbUATRxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265635AbUATRxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:53:34 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:23890 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265633AbUATRxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:53:17 -0500
Message-ID: <400D6A5B.7090009@sgi.com>
Date: Tue, 20 Jan 2004 11:50:19 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix updates
References: <200401152154.i0FLscIG023452@fsgi900.americas.sgi.com> <20040116144132.A24555@infradead.org>
In-Reply-To: <20040116144132.A24555@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Thu, Jan 15, 2004 at 03:54:37PM -0600, Pat Gefre wrote:
>  
>
>>001-reorg.patch
>>002-reorg1.patch
>>    
>>
>
>The IS_IOADDR() stuff in the accesor funcs in pcibr_reg.c is completly
>bogus, please decide whether you want to pass a pointer to the pcibr_soft
>or bridge_t to it instead of doing second-guessing.
>
>  
>

Yes this probably looks a little odd. This was setup this way for TIO. 
The macro in the TIO code checks to see
if it is a 'soft' struct or bridge address AND what bridge type it is - 
accessing different registers depending
on TIO or not TIO (the 2 cases we have so far). We think this makes the 
register access functions pretty flexible/generic.

>Also while the pic.h changes look okay they will conflict with a patch
>I'm about to send that adds common headers for the bridge/xbow/xwidget
>register for mips and IA64.  Can you send me a version of pic.h with
>those changes and the big endian ifdefs back in so I can just incorporate
>the new version into my patch?
>
>  
>

OK - I'll look into getting this for you.

>Also are all those access you abstract away different in TIOCP?  If not
>please don't add the wrappers for them.
>  
>


