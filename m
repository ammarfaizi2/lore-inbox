Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265756AbRGCSYc>; Tue, 3 Jul 2001 14:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265752AbRGCSYW>; Tue, 3 Jul 2001 14:24:22 -0400
Received: from mysql.sashanet.com ([209.181.82.108]:11939 "EHLO
	mysql.sashanet.com") by vger.kernel.org with ESMTP
	id <S265747AbRGCSYP>; Tue, 3 Jul 2001 14:24:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Sasha Pachev <sasha@mysql.com>
Organization: MySQL
To: linux-kernel@vger.kernel.org
Subject: Strange thread behaviour on 8-way x86 machine
Date: Tue, 3 Jul 2001 12:25:12 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <0107031225120K.18621@mysql>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have observed a rather strange behaviour doing a multi-threaded CPU 
benchmark on an 8-way machine running 2.4.2 SMP kernel. Even when the 
priority is reniced to the highest possible value, I am still unable to reach 
more than 50% CPU utilization. My benchmark just creates a bunch of threads 
with pthread_create(), and then runs a simple integer computation in each 
thread. On a dual with 2.4.3 kernel, and a 4-way with 2.4.2 kernel, I am able 
to reach full CPU utilization. 

At first glance, it appears to be like some overzealous fairness problem in 
the scheduler that is exhibited only when you have more than 4 CPUs. Before I 
start scrutinizing the source trying to understand the inner workings of the 
scheduler, I would like to get some feedback from people that know something 
about the subject. Any ideas/suggestions would be appreciated.

-- 
MySQL Development Team
For technical support contracts, visit https://order.mysql.com/
   __  ___     ___ ____  __ 
  /  |/  /_ __/ __/ __ \/ /   Sasha Pachev <sasha@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__  MySQL AB, http://www.mysql.com/
/_/  /_/\_, /___/\___\_\___/  Provo, Utah, USA
       <___/                  
