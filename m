Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbREPXbc>; Wed, 16 May 2001 19:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbREPXbX>; Wed, 16 May 2001 19:31:23 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:15496 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S261337AbREPXbN>; Wed, 16 May 2001 19:31:13 -0400
From: Simon Geard <simon.geard@ntlworld.com>
Date: Thu, 17 May 2001 01:32:12 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Problem with make xconfig and tcl/tk 8.3 (and fix)
MIME-Version: 1.0
Message-Id: <01051701321300.01308@Granville>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tcl/tk8.3.2 installed and make xconfig (for both 2.2.18 and 2.4.2) 
just hang. I've been told by the listed maintainer that a new GUI is on its 
way and the existing make xconfig is orphaned, but this does not solve the 
immediate problem.

I have therefore fixed this problem myself and have patches for header.tk and 
tail.tk if anyone is interested. Essentially the fix is to replace all the 
'exec ...' commands with native Tcl ones. I have also enhanced the help 
system so that the help is cached internally on startup and its existence is 
used to control the state of the help button, this makes getting help much 
faster and more reliable (RTFM messages are no longer needed). The help 
itself now has a blue title that points back to the originating entry.

I'm happy to provide these if anyone is interested, I have tested them with 
tcl/tk8.2.0 as well and as far as I can see they work fine. The sizes are

wc -l *patch*
    322 header.tk.patch
     39 tail.tk.patch-2.2.18
     61 tail.tk.patch-2.4.2 


I'm not subscribed to the list so please cc replies to me if you wish.

Thanks,

Simon Geard.
