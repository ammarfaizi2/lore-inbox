Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129959AbQLGRfi>; Thu, 7 Dec 2000 12:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131598AbQLGRf2>; Thu, 7 Dec 2000 12:35:28 -0500
Received: from h50s48a140n47.user.nortelnetworks.com ([47.140.48.50]:56201
	"EHLO zrtps06s.us.nortel.com") by vger.kernel.org with ESMTP
	id <S129959AbQLGRfN>; Thu, 7 Dec 2000 12:35:13 -0500
Message-ID: <3A2FC0C6.3F11057B@nortelnetworks.com>
Date: Thu, 07 Dec 2000 11:54:30 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: Kotsovinos Vangelis <kotsovin@ics.forth.gr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Microsecond accuracy
In-Reply-To: <Pine.GSO.4.10.10012071337530.7874-100000@athena.ics.forth.gr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kotsovinos Vangelis wrote:
> 
> Is there any way to measure (with microsecond accuracy) the time of a
> program execution (without using Machine Specific Registers) ?
> I've already tried getrusage(), times() and clock() but they all have
> 10 millisecond accuracy, even though they claim to have microsecond
> acuracy.
> The only thing that seems to work is to use one of the tools that measure
> performanc through accessing the machine specific registers. They give you
> the ability to measure the clock cycles used, but their accuracy is also
> very low from what I have seen up to now.

Can you not just use something like gettimeofday()?  Do two consecutive calls to
find the execution time of the instruction itself, and then do two calls on
either side of the program execution.  Subtract the instruction execution time
from the delta, and that should give a pretty good idea of execution time.

On a 400Mhz G4, getttimeofday() consistantly takes 2 microseconds to run.

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
