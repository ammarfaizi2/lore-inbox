Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTETBRX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263445AbTETBRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:17:23 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:17833 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S263441AbTETBRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:17:21 -0400
Message-ID: <3EC98525.80402@mvista.com>
Date: Mon, 19 May 2003 20:30:13 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add boot command line parsing for the e100 driver
References: <Pine.SOL.4.30.0305200243380.28757-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0305200243380.28757-100000@mion.elka.pw.edu.pl>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>On Tue, 20 May 2003, Bartlomiej Zolnierkiewicz wrote:
>  
>
>>On Mon, 19 May 2003, Corey Minyard wrote:
>>
>>    
>>
>>>Jeff Garzik wrote:
>>>
>>>      
>>>
>>>>>instead of adding such horrible cruft Corey did it should just use the
>>>>>proper API.
>>>>>
>>>>>
>>>>>          
>>>>>
>>>>An API already exists, and it is source compatible between 2.4 and 2.5:
>>>>ethX=.... on the kernel command line.
>>>>
>>>>The proper patch would pick up options from there.
>>>>
>>>>        
>>>>
>>>Can you tell me where this is?  I found the "ether=xxx" and
>>>"netdev=xxx", but they are not suitible.  I also could not find
>>>"module_parame" anywhere on google or in the kernel.
>>>
>>>-Corey
>>>      
>>>
>>:-) module_parm(), look at include/linux/moduleparam.h
>>and scsi for usage examples
>>    
>>
>
>ugh. s/module_parm/module_param/
>
Thank you.  Nobody seems to be able to type correctly today :-).  I had
actually found it, and looked it over.  It looks pretty nice, although
the lack of documentation is somewhat annoying.

However, if the ethX=.... exists, I would far prefer to use that.  (The
parameters for what  am doing have to be at bootup to work, it can't be
after the fact.  I hunted for a while, and I still couldn't find it,
btw.)  Otherwise, it's really up to the driver maintainers.  I will
adjust as they want, I will use the module_param stuff or the old
__setup stuff.  I would like to get this in, though.

-Corey

