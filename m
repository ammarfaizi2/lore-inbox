Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTDGOIP (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTDGOIP (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:08:15 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:60040 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263451AbTDGOII (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 10:08:08 -0400
Message-ID: <3E9188ED.1090109@nortelnetworks.com>
Date: Mon, 07 Apr 2003 10:19:25 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Thomas Schlichter <schlicht@rumms.uni-mannheim.de>,
       linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
References: <200304071026.47557.schlicht@uni-mannheim.de> <200304072021.17080.kernel@kolivas.org> <1049712476.3e91575c2e6ae@rumms.uni-mannheim.de> <3E917BFA.4020303@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Thomas Schlichter wrote:
> 
>> What I wanted to say is that if there is free memory it should be 
>> filled with
>> the pages that were in use before the memory got rare. And these are 
>> the pages
>> swapped out last. 

> "What we're going to need soon" is the best.  It isn't always predictable,
> but sometimes.  "The block following the last we read from some 
> file/fs-structure"
> is often a good one though.

With the current setup though, the memory is wasted.  It makes sense that we 
should fill the memory up with *something* that is likely to be useful.

If I have mozilla open, start a kernel compile, and then come back half an hour 
later, I would like to see the mozilla pages speculatively loaded back into memory.

Since the system is otherwise idle, it doesn't cost anything to do this.  I 
think its obvious that it is beneficial to swap in something, the only trick is 
getting a decent heuristic as to what it should be.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

