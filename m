Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266709AbUBQW4s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbUBQW4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:56:13 -0500
Received: from mail.networld.com ([209.63.232.103]:60685 "EHLO networld.com")
	by vger.kernel.org with ESMTP id S266718AbUBQWxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:53:25 -0500
Message-ID: <40329B57.9060901@networld.com>
Date: Tue, 17 Feb 2004 15:53:11 -0700
From: Charles Johnston <cjohnston@networld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en, pt-br, pt, es, ko, ko-kr
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc4 Massive strange corruption with new radeonfb
References: <403274D2.4020407@networld.com> <1077055997.1076.23.camel@gaston>
In-Reply-To: <1077055997.1076.23.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Wed, 2004-02-18 at 07:08, Charles Johnston wrote:
> 
>>Upon bootup, radeonfb is obviously not initializing the hardware 
>>correctly.  Massive amounts of random-looking garbage, plus a weird 
>>effect I've never seen before, like someone pouring milk _up_ the
>>screen. (Yeah, it's the best I could come up with)
>>
>>It's a Dell Inspiron 8600 with Mobile Radeon 9600 and 1920x1200 LCD.
> 
> 
> Looks like the driver cannot find any info about your flat panel
> in the BIOS ROM image. I suppose we can thank DELL for hacking the
> BIOS in ways that aren't compatible with all others laptops...
> 
> Can you try commenting out the call to radeon_map_ROM() and let it
> look for the RAM based BIOS instead ? Let me know...
>  

Ok, it worked fine with that line commented out.  I can switch vt's, be 
in X, etc. no problems.

The only issue I see is when I do a 'clear' on the vt, it doesn't clear 
the text, but blanks every nth row of pixels.  Switching vt's and back 
clears the screen.

There are also a few rows of garbage pixels at the bottom that linger 
across vt switches.


Charles Johnston
cjohnston@networld.com
