Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVKZKhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVKZKhx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 05:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVKZKhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 05:37:53 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:63156 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750775AbVKZKhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 05:37:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=LlHhGcOxL/b+JacZANnkrB2XZlaoKhPtw0yZMTeQ8nw9oDavrP2Ih1qq4eKBX8YKhiKiYjl6IUao/UOhEtro52m71rLDjvp/6rRCJT+k3J3ljq+oITwwN84F4OPWUvAYrjHbw3NenZ03AqmRJSDOKDWFrbScQc5gBYW4npzU3rI=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: mingo@elte.hu
Subject: 2.6.14-rt15 @x86_64UP: "sem_post: Invalid argument"
Date: Sat, 26 Nov 2005 11:40:47 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511261140.47931.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get loads of those messages since switching from rt12 to rt15.
no other known change.

They happen during startup and when I trigger
i.e. an ardour build like this:
	$ scons

a typical strace excerpt:
----
futex(0x5012a0, FUTEX_WAKE, 1)          = -1 EINVAL (Invalid argument)
write(2, "sem_post: Invalid argument\n", 27) = 27
----

Other futex() calls like
----
futex(0x3b384030c8, FUTEX_WAKE, 2147483647) = 0
----
succeed.
  
This happens on fc4.
Maybe caused by a recent change from a semaphore to completion?

      Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
