Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267776AbTAMDcQ>; Sun, 12 Jan 2003 22:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267775AbTAMDcQ>; Sun, 12 Jan 2003 22:32:16 -0500
Received: from granger.mail.mindspring.net ([207.69.200.148]:30779 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S267782AbTAMDcM>; Sun, 12 Jan 2003 22:32:12 -0500
Message-ID: <3E22356F.2000205@emageon.com>
Date: Sun, 12 Jan 2003 21:41:35 -0600
From: Brian Tinsley <btinsley@emageon.com>
Organization: Emageon
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jakma <paulj@alphyra.ie>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440) [rescued]
References: <Pine.LNX.4.44.0301130257020.26185-100000@dunlop.admin.ie.alphyra.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Which driver are you using for the QLA23xx?
>
The 6.01.00-fo driver from QLogic.

>I've missed the beginning of this thread, but problem here may not 
>have anything to with the number of threads you're runnng, rather it 
>may well be the qla2300 driver, if you are using the qlogic v6 driver.
>
I was getting nailed by an issue involving reaping inodes (or the lack 
thereof). I don't believe the QLogic driver was contributing to my 
problem. I've had this driver running in my lab and at numerous client 
sites for quite some time and have never seen it even burp.

>I have a test system in work which is similar to yours (2x qla2310F,
>SMP (dual athlon) attached to FC RAID storage) and it is easy to live
>lock with any kind of intensive IO, eg bonnie++.
>
>The Redhat 5.31-RH driver is about the most stable one, but i havnt
>extensively stress tested it. All of the qlogic v6 drivers are trivial
>to lock. (they spin forever in the qla2300 ISR - qlogic have beta
>drivers, but they still have the same problem).
>
Interesting. Again, I've never seen this behavior, but I appreciate your 
mentioning it. It's definitely something to keep an eye out for.

-- 

Brian Tinsley
Chief Systems Engineer
Emageon



