Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319365AbSHVPg4>; Thu, 22 Aug 2002 11:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319368AbSHVPg4>; Thu, 22 Aug 2002 11:36:56 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:43209 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S319365AbSHVPg4>; Thu, 22 Aug 2002 11:36:56 -0400
Message-ID: <3D6505FA.4E7F4978@nortelnetworks.com>
Date: Thu, 22 Aug 2002 11:40:42 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
References: <80256C17.00376E92.00@notesmta.eur.3com.com> <20020816195254.GL5418@waste.org> <3D5D6621.E33EA4BE@nortelnetworks.com> <ak1l8c$drl$2@abraham.cs.berkeley.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:

>   "If you have an embedded system that is headless, etc., then your
>   only remaining source of entropy is /dev/zero."
> 
> Well, sometimes there is just no reliable entropy source on hand.
> Maybe it's better to admit that than to fool ourselves.

And if you could time to the nanosecond exactly when each zero was read in, and the latencies in
this reading are varying with the rest of the workload on the machine, then yes, you can get entropy
reading from /dev/zero.

I submit that if you have an attacker with the resources to model and predict your interrupt
handling down to the timing of the pci bus (ie 30 nanoseconds) from across the other end of your LAN
then you will probably have the resources to use a hardware RNG.  If you don't have those resources,
chances are good that your competitors don't have the ability to do the requesite network
modelling/influencing.

It's a calculated risk, but I would argue that some security (even if theoretically compromiseable)
is better than none.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
