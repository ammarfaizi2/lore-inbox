Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTDXDiC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 23:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTDXDiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 23:38:01 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:7607 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id S264254AbTDXDiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 23:38:00 -0400
Message-ID: <3EA75EDD.20605@blue-labs.org>
Date: Wed, 23 Apr 2003 23:49:49 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Grover, Andrew" <andrew.grover@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com> <20030424000344.GC32577@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20030424000344.GC32577@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I honestly don't see OOMing as an acceptable practice.  If I wanted to 
kill a bunch of stuff just to suspend, I would have simply shut the 
system down.  That isn't my intent or desire.  I want to suspend the 
system just as it is without OOMing a bunch of programs.

David

Pavel Machek wrote:

>Hi!
>
>  
>
>>>From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
>>>Can't you just create a pre-reserved separate swsusp area on 
>>>disk the size 
>>>of RAM (maybe a partition rather than a file to make things 
>>>easier), and 
>>>then you know you're safe (basically what Marc was 
>>>suggesting, except pre-allocated)? Or does that make me the 
>>>prince of all evil? ;-)
>>>
>>>However much swap space you allocate, it can always all be 
>>>used, so that seems futile ...
>>>      
>>>
>>This is what Other OSes do, and I believe this is the correct path.
>>Using swap for swsusp is a clever hack but not a 100% solution.
>>    
>>
>
>Well, for normal use its clearly inferior -- suspend partition is unused
>when it could be used for speeding system up by swapping out unused
>stuff.
>
>OtherOS approach is better because it can guarantee suspend-to-disk
>for critical situations like overheat or battery-critical.
>
>But we can get best of both worlds if we OOM-kill during critical
>suspend. [If suspend partition was not used for swapping, machine
>would *already* OOM-killed someone, so we are only improving stuff].
>
>						Pavel  
>
>  
>

