Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269326AbRH1UjV>; Tue, 28 Aug 2001 16:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRH1UjM>; Tue, 28 Aug 2001 16:39:12 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:54473
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S269326AbRH1Ui6>; Tue, 28 Aug 2001 16:38:58 -0400
Message-ID: <3B8C015A.88C1103C@nortelnetworks.com>
Date: Tue, 28 Aug 2001 16:38:50 -0400
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: Treating parallel port as serial device
In-Reply-To: <9mgtpb$mf4$1@sisko.my.home>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Hoyle wrote:

> What I need now is a driver that can read the input from a  pin on the
> parallel port and treat it as serial input.  It sounds like the kind of
> project that would have been done before, but I can't find anything that
> even comes close.  Userspace probably wouldn't cut it as I'm reading as
> 9600 baud and usleep doesn't have nearly enough resolution.

Unless you need to drive this based on interrupts or you need to do other stuff
at the same time, you can use either SCHED_FIFO or SCHED_RR and nanosleep() from
userspace.

According to the man page, nanosleep() will busywait for pauses under 2ms if you
use one of the two realtime schedulers.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
