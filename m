Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271005AbRHXJQS>; Fri, 24 Aug 2001 05:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271006AbRHXJQI>; Fri, 24 Aug 2001 05:16:08 -0400
Received: from 205-158-62-59.outblaze.com ([205.158.62.59]:65446 "HELO
	ws1-8.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S271005AbRHXJQA>; Fri, 24 Aug 2001 05:16:00 -0400
Message-ID: <20010824084729.19008.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Anwar P" <anwarp@mail.com>
To: linux-kernel@vger.kernel.org
Date: Fri, 24 Aug 2001 16:47:28 +0800
Subject: What version of the kernel fixes these VM issues?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -
 
We have big system (8 processors, 8GB ram), running Oracle and this other ETL tool.  Oracle is up and running all the time, and the ETL tool runs once a day.  But everytime the ETL tool runs (along with Oracle), the system seems to run out of memory, and the server comes to a crawl, often with keyborad response in 10 to 15 minute intervals.  We are currently using the 2.4.3-6 kernel that comes with Redhat 7.1.
 
We know that Oracle comsumes no more than 2GB of memory at peak usage, and the ETL tool itself consumes less than 1GB.  But the ETL tool does process a whole bunch of text files (total about 6GB worth of), and it runs for about 2 hours.  What happens is that while they are both running, the filesystem cache size increases progressively, and some time later, it begins swapping.  We do have 16GB (2x RAM) of swap.  And when it starts to swap, the server responds to keystrokes/commands randomly and appears dead for 10s of minutes. We know that together our applications do not need more than 4GB of RAM on this 8GB box, so it is the VM that is causing this unnecessary swapping by trying to use too much memory for filesystem cache.   
 
So the first question is, is there any way I can limit the amount of memory used for FS cache ?
 
And the next one is, are there any (later) versions of the kernel that are more sane about what the maximum FS cache it should use is ?  It is strange that the FS caching does not take into account the amount of physical RAM on the box.  What is the point in doing FS caching when the end result is thrashing and the machine becomes unusable ?  
 
Anwar.

-- 

_______________________________________________
FREE Personalized E-mail at Mail.com 
http://www.mail.com/?sr=signup 

Talk More, Pay Less with Net2Phone Direct(R), up to 1500 minutes free! 
http://www.net2phone.com/cgi-bin/link.cgi?143 

