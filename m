Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314653AbSEPUIR>; Thu, 16 May 2002 16:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314656AbSEPUIQ>; Thu, 16 May 2002 16:08:16 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:22753 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id <S314653AbSEPUIP>; Thu, 16 May 2002 16:08:15 -0400
Date: Thu, 16 May 2002 16:08:15 -0400 (EDT)
From: Paul Faure <paul@engsoc.org>
X-X-Sender: <paul@lager.engsoc.carleton.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Process priority in 2.4.18 (RedHat 7.3)
Message-ID: <Pine.LNX.4.33.0205161552470.17862-100000@lager.engsoc.carleton.ca>
X-Home-Page: http://www.engsoc.org/
X-URL: http://www.engsoc.org/
Organisation: Engsoc Project (www.engsoc.org)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just installed RedHat 7.3 with kernel 2.4.18 and noticed that my network 
no longer functions when my CPU usage is at 100%.  Looking at the 
priorities of the application that I was running showed a priority of 35 
(thats what `nice ./test` produces).  Then looking at the priorities of 
all the other processes shows a range from 15 to 35.

All the main kernel processes run at 15 except ksoftirqd_CPU0 and 
ksoftirqd_CPU1 which run at 35.

None of the documentation on my system (`man nice` etc...) mentions
anything about priority levels between 15 and 35, they all say -20 to +20
(as it used to be).

So, why the change the priority levels?  And why my test app (at any 
priority level) starves out my network?

I am running an SMP box.

Thanks.

-- 
Paul N. Faure					613.266.3286
EngSoc Administrator            		paul-at-engsoc-dot-org
Chief Technical Officer, CertainKey Inc.	paul-at-certainkey-dot-com
Carleton University Systems Eng. 4th Year	paul-at-faure-dot-ca



