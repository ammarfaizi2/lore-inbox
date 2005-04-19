Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVDSQqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVDSQqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 12:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVDSQqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 12:46:23 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:19845 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261622AbVDSQqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 12:46:20 -0400
Message-ID: <426535D8.5020406@nortel.com>
Date: Tue, 19 Apr 2005 10:46:16 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question on 2.4 scheduler, threads, and priority inversion
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to be having an issue with 2.4 and linuxthreads.

I have a program that spawns a child thread, and that child boosts 
itself into a realtime scheduler class.

The child then went crazy and turned into a cpu hog.  At this point, a 
higher-priority task detected the hog, and tried to kill the process by 
sending a "kill -9" to the main thread.  Unfortunately, it appears that 
there is some kind of priority-inversion thing happening, as the process 
did not die.

Is this expected behaviour?  Is there any way around this?  Do I need to 
put the main thread at a higher priority than any of the child threads? 
  What about the manager thread?

Thanks,

Chris
