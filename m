Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTDGN5o (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263465AbTDGN5n (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:57:43 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:35302 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263462AbTDGN5m (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 09:57:42 -0400
Message-ID: <3E91866C.2000902@nortelnetworks.com>
Date: Mon, 07 Apr 2003 10:08:44 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: correct to set -nostdinc and then include <stdarg.h> ?
References: <3E910172.8030406@nortelnetworks.com> <23076.1049692512@kao2.melbourne.sgi.com> <20030407074722.A9367@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Apr 07, 2003 at 03:15:12PM +1000, Keith Owens wrote:

>>On Mon, 07 Apr 2003 00:41:22 -0400, 
>>Chris Friesen <cfriesen@nortelnetworks.com> wrote:
>>
>>>I was trying to compile 2.5.66 with gcc 3.2.2.  It dies as soon as it tries to 
>>>compile init/main.c because it is unable to find "stdarg.h" which is included by 
>>>"include/linux/kernel.h".
>>>
> 
> stdarg.h is part of the compiler specific includes.  We want to pick
> up on these, so we use "-iwithprefix include" to add the compiler specific
> includes back.

It doesn't seem to work with gcc 3.2.2 then.

> Unfortunately, there seems to be something wrong with GCC's ability to
> determine where these includes really reside when GCC is installed in
> a different location to the one it was configured with.  In other words,
> don't do that.  Install GCC to the location where you told it to be
> installed.

gcc was configured with a prefix of "/usr/local/gcc322" and installed using 
"make install".  It still gave the error.  Is this a gcc bug?  I'm at work now, 
but I can run the command you gave this evening to check the results.



Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

