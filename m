Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSFRMwS>; Tue, 18 Jun 2002 08:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSFRMwR>; Tue, 18 Jun 2002 08:52:17 -0400
Received: from employees.nextframe.net ([212.169.100.200]:65522 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S317398AbSFRMwR>; Tue, 18 Jun 2002 08:52:17 -0400
Date: Tue, 18 Jun 2002 15:00:55 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Getting rid of check_region()
Message-ID: <20020618150055.E129@sexything>
Reply-To: morten.helgesen@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys.

It`s time for some real janitor work :)

I`ve taken a clean 2.5.22 tree, and started removing
instances of check_region(). It has been on the kernel janitors`
TODO list for a long time. 

It struck me that it might be a good idea to see if anyone had any comments 
or even objections before spending X hours killing it off :-)

I see that there are lots of places where we can just remove
check_region() and instead just check the return value from
request_region(), but I`m also sure we have corner cases where
driver authors are doing 'nifty' things with check_region(), and 
these drivers might need a bit more surgery. I will contact
the driver authors and ask for their comments if I can not figure out
how to work around using check_region() in the specific driver.

When done, I`ll submit separate patches for separate directories.

Does this sound like a sane approach to you guys ?

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
