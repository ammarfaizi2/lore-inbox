Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269290AbRGaN3b>; Tue, 31 Jul 2001 09:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269291AbRGaN3V>; Tue, 31 Jul 2001 09:29:21 -0400
Received: from [47.129.117.131] ([47.129.117.131]:62090 "HELO
	pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S269290AbRGaN3L>; Tue, 31 Jul 2001 09:29:11 -0400
Message-ID: <3B66B2AF.43D1197E@nortelnetworks.com>
Date: Tue, 31 Jul 2001 09:29:19 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: subhash.sutrave@oracle.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about gettimeofday
In-Reply-To: <3B65F3A2.DC5F7E37@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Subhash S wrote:
> 
> Hi All,
> 
> In my application I use gettimeofday very frequently, as it is system
> call on linux it is expensive, where as on Solaris it is not so. Could
> you please tell me how solaris is implemented the function gettimeofday.

While I can't tell you how Solaris implemented it, I can say that in general if
you want very frequent timing access you're probably better off using inline
assembly to get at some processor-specific timer.  On a 400Mhz G4, the
difference was about a microsecond for gettimeofday() vs about 25 nanoseconds
for the assembly code.


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
