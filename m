Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312687AbSDAXAj>; Mon, 1 Apr 2002 18:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312684AbSDAXAa>; Mon, 1 Apr 2002 18:00:30 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:49631 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S312687AbSDAXAU>; Mon, 1 Apr 2002 18:00:20 -0500
Message-ID: <3CA8E8D5.B8B648ED@nortelnetworks.com>
Date: Mon, 01 Apr 2002 18:10:13 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about scheduler changes from 2.2 to 2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the 2.2 scheduler there was a section that checked if the previous process
was still runnable and set it as the default next running process.  It looked
like this:

	if (prev->state == TASK_RUNNING)
	   goto still_running;
still_running_back:

With another chunk of code under still_running that set "c" and "next".

In 2.4 this seems to have been removed.  Can someone explain why?  I'm porting
some custom scheduler changes and want to make sure that I understand what's
going on in 2.4.

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
