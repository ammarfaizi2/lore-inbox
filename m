Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266327AbUHPS2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUHPS2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUHPS2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:28:35 -0400
Received: from mail.timesys.com ([65.117.135.102]:44044 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S266327AbUHPS2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:28:33 -0400
Message-ID: <4120FCD0.2090305@timesys.com>
Date: Mon, 16 Aug 2004 14:28:32 -0400
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Dan Malek <dan@embeddededge.com>, Kumar Gala <kumar.gala@freescale.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [BUG] PPC math-emu multiply problem
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com> <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com> <410A5F08.90103@timesys.com> <410A67EA.80705@timesys.com> <20040809165650.GA22109@smtp.west.cox.net> <6FBD1B21-EA2B-11D8-8382-003065F9B7DC@embeddededge.com> <20040809222328.GB22109@smtp.west.cox.net> <4120B055.8090503@timesys.com> <20040816144829.GC2377@smtp.west.cox.net>
In-Reply-To: <20040816144829.GC2377@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2004 18:27:10.0203 (UTC) FILETIME=[A49D8CB0:01C483BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:

>>The way I got the LSB tests to pass was to remove the round in the 
>>denormalised underflow case. This appears to match the hardware 
>>behavior. I've not looked at the PPC floating point model close enough 
>>to know if this is proper behavior. It is what the LSB tests are 
>>expecting and doesn't cause a failure in any of the other LSB tests.
>>    
>>
>
>Have you guys run the LSB tests on some PPC with hw floating point (is
>that what you mean by 'matches the hardware behavior' ?) to see if the
>test also passes there as-is?  And does anyone object to this patch?
>Now that 2.6.8.1 is out I'm gonna start committing in a bunch of stuff
>I've had queued up and see if I can get Linus to pull.  Thanks.
>
>  
>
I didn't run the entire LSB, just some of the math tests. I had an 8260 
and the 8560 we found the problem on and also a normal x86 box. I think 
this is the correct fix. At least all of the LSB math tests pass now and 
the LTP float tests don't complain.

Greg Weeks
