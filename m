Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422681AbWAMOUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbWAMOUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWAMOUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:20:45 -0500
Received: from odin2.bull.net ([192.90.70.84]:54239 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1422681AbWAMOUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:20:44 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
Subject: RT question : softirq and minimal user RT priority
Date: Fri, 13 Jan 2006 15:27:00 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Message-Id: <200601131527.00828.Serge.Noiraud@bull.net>
X-MIMETrack: Itemize by SMTP Server on MSGB-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 01/13/2006 03:21:37 PM,
	Serialize by Router on MSGB-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 01/13/2006 03:21:39 PM,
	Serialize complete at 01/13/2006 03:21:39 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I was testing 2.6.15-rt3. During my tests, I tried to run a program which made a loop at
RT priority 10 and 30.
I was very happy to see that after the tests, I can't use any command except those already in memory.
My filesystems were in read-only after the test. I was unable to shutdown the machine : 
top => command not found
<CTRL><ALT><DEL> => INIT: cannot execute "/sbin/shutdown"
/sbin/reboot   => Input/Output error
I had to push the reset button.

My questions are : 
Did I find a bug ?
Is the smallest usable real-time priority greater than the highest real-time softirq ?
In this case could we forbid priority lesser than the highest softirq priority ?
