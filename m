Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272270AbRH3P3s>; Thu, 30 Aug 2001 11:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272268AbRH3P3j>; Thu, 30 Aug 2001 11:29:39 -0400
Received: from h157s242a129n47.user.nortelnetworks.com ([47.129.242.157]:56313
	"EHLO zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S272270AbRH3P3Z>; Thu, 30 Aug 2001 11:29:25 -0400
Message-ID: <3B8E5BD9.7CC0D854@nortelnetworks.com>
Date: Thu, 30 Aug 2001 11:29:29 -0400
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question about netlink/rtnetlink sockets
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working on writing some code that talks to the kernel over a netlink socket
and manipulates IP addresses, rules, and routes.

I've gotten it working, except for the case of adding an address that is already
present.  I would like to either ignore or replace it if it is already there
(haven't decided which yet) but currently I get an EEXIST error. (Which is
understandable, but I'd like to get rid of it.)  I tried setting the
NLM_F_REPLACE flag (which works when trying to add a route that already exists)
but this didn't seem to do anything.  Neither did NLM_F_EXCL.

Is this the expected behaviour?  Is there some reason why we don't replace it
with the newly specified address?  If there is no serious reason, could you
point me towards the code controlling this?  I'm on 2.2.

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
