Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314603AbSDTKPZ>; Sat, 20 Apr 2002 06:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314604AbSDTKPY>; Sat, 20 Apr 2002 06:15:24 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:54281 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S314603AbSDTKPX>;
	Sat, 20 Apr 2002 06:15:23 -0400
Date: Sat, 20 Apr 2002 19:14:19 +0900 (JST)
Message-Id: <20020420.191419.35011774.taka@valinux.co.jp>
To: habanero@us.ibm.com
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <200204192128.QAA24592@popmail.austin.ibm.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> With all this talk on serialization on UDP, and have a question.  first, let 
> me explain the situation.  I have an NFS test which calls 48 clients to read 
> the same 200 MB file on the same server.  I record the time for all the 
> clients to finish and then calculate the total throughput. The server is a 
> 4-way IA32.  (I used this test to measure the zerocopy/tcp/nfs patch)  Now, 
> right before the test, the 200 MB file is created on the server, so there is 
> no disk IO at all during the test.  It's just an very simple cached read.  
> Now, when the clients use udp, I can only get a run queue length of 1, and I 
> have confirmed there is only one nfsd thread in svc_process() at one time, 
> and I am 65% idle.  With tcp, I can get all nfsd threads running, and max all 
> CPUs.  Am I experiencing a bottleneck/serialization due to a single UDP 
> socket?  

What version do you use?
2.5.8 kernel has a problem in readahead of NFSD.
It doesn't work at all.

It can be easy to fix.

Thank you,
Hirokazu Takahashi.
