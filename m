Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTCKJUB>; Tue, 11 Mar 2003 04:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbTCKJUB>; Tue, 11 Mar 2003 04:20:01 -0500
Received: from [203.124.139.208] ([203.124.139.208]:12080 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id <S262871AbTCKJUA>;
	Tue, 11 Mar 2003 04:20:00 -0500
Reply-To: <chandrasekhar.nagaraj@patni.com>
From: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Load Balancing Performance
Date: Tue, 11 Mar 2003 15:28:14 +0530
Message-ID: <000001c2e7b4$bc52fcc0$e9bba5cc@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a device driver which is on top of the "sd" driver (i.e it forwards
the requests to the  sd driver with various features implemented like load
balance,fail over etc).
Suppose we are having 4 paths to the same Logical Unit(LU),it is possible to
do load balance  amongst these 4 paths.
Now if we want to send a data of 1000 buffer heads ,on each call of the make
request of our  driver we select the appropriate path and pass it to sd
(this is how we achieve load balancing)  and hence 250 buffer heads are sent
through each path.But the performance is not up to the mark.
But instead of path switching for every buffer head (on call of make
request), if we switch after  50 buffer heads(ie. after 50 times make
request is called) then it results in a better  performance.
Is there any way to find out the optimum value so that the performance is
optimum.
The performance is not good only when load balancing is ON. Hence we need
performance improvement  in the case of load balancing.
Or is there any other solution to this problem.

Thanks and Regards
Chandrasekhar

