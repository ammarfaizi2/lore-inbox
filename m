Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUBTPsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUBTPhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:37:37 -0500
Received: from [195.23.16.24] ([195.23.16.24]:19107 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261290AbUBTPdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:33:00 -0500
Message-ID: <40362863.9090109@grupopie.com>
Date: Fri, 20 Feb 2004 15:31:47 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andy Lutomirski <amluto@hotmail.com>
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
References: <fa.d7mjamc.1l40pri@ifi.uio.no> <4035AA75.1060109@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski wrote:

> Greg KH wrote:
> 
>>
>> Paulo Marques:
>>   o USB: fix usblp.c
>>
> 
> Unless I'm missing something, this won't fix the usblp_write spinning 
> bug I hit.  If it helps, I can try to reproduce it with some debugging 
> code attached.
> 


That is why on our latest thread about this I requested that you tested the 
patch to check your bug went way.

My patch *does* correct *a* bug. I tested it myself because I could trigger the 
bug easily, and after the patch the bug was gone.

I just wanted you to test if our bugs were different, or on the contrary, they 
are in fact the same.

They could be the same, because in my case, the driver would hang sending 
garbage to the printer. Because the printer was a dot-matrix "print what it 
receives" kind of printer, it would output the garbage continously. If it were a 
more "inteligent" printer it might refuse the garbage and not print anything at 
all, giving the same result as if nothing was being printed.

Anyway, if the bugs are different, then yes, another patch is needed to fix 
"your" bug :)

You will be the best person to do it, since you can trigger the bug, and test a 
before / after scenario.

-- 
Paulo Marques - www.grupopie.com

"In a world without walls and fences who needs windows and gates?"

