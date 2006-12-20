Return-Path: <linux-kernel-owner+w=401wt.eu-S1030406AbWLTWg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWLTWg7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030408AbWLTWg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:36:59 -0500
Received: from mail.tmr.com ([64.65.253.246]:57913 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030406AbWLTWg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:36:58 -0500
Message-ID: <4589BC6E.7040209@tmr.com>
Date: Wed, 20 Dec 2006 17:42:54 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Dave Jones <davej@redhat.com>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: my handy-dandy, "coding style" script
References: <Pine.LNX.4.64.0612191044170.7588@localhost.localdomain>  <20061219164146.GI25461@redhat.com> <b6c5339f0612190942l5a3ea48ft3315ab991ffd4f32@mail.gmail.com> <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612192125460.20733@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>>  just for fun, i threw the following together to peruse the tree (or
>>>> any subdirectory) and look for stuff that violates the CodingStyle
>>>> guide.  clearly, it's far from complete and very ad hoc, but it's
>>>> amusing.  extra searches happily accepted.
>>> I had a bunch of similar greps that I've recently been half-assedly
>>> putting together into a single script too.
>>> See http://www.codemonkey.org.uk/projects/findbugs/
>> I don't know if anyone cares about them anymore, since I think gcc
>> grew some smarts in the area recently, but there are a lot of lines of
>> code matching "static int.*= *0;" and equivalents in the driver tree.
> 
> I'd really like to see the C compiler being enhanced to detect
> "stupid casts", i.e. those, which when removed, do not change (a) the outcome
> (b) the compiler warnings/error output.

Bearing in mind that some casts may have been put in when struct members 
had other values, may be needed on some hardware but not others, etc. 
Cleanups are good, but may not be as obvious as they appear.

Not that there's a lack of places to remove visual cruft, but perhaps 
someone could look at casts and ask if each hides a real type mismatch.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
