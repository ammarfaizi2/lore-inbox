Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268916AbRHPWXq>; Thu, 16 Aug 2001 18:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268929AbRHPWXh>; Thu, 16 Aug 2001 18:23:37 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:52494 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S268916AbRHPWXY>; Thu, 16 Aug 2001 18:23:24 -0400
Message-Id: <200108162223.f7GMNat10203@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: linux-kernel@vger.kernel.org
Subject: kernel threads
Date: Fri, 17 Aug 2001 00:23:35 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm new to in developing kernel software under linux and what to 
know if i'm write when i create kernel_threads like this:

variant I
---------
1) call kernel_thread 
2) in the thread function 
    a) get the big kernel lock
    b) call daemonize
    c) release big kernel lock


variant II
----------
schedule the call to kernel_thread using tq_schedule


- is there no need to call daemonize in the second variant - if yes why?
- can i do both variants during interupt time (when there is no valid 
current)?

chris
