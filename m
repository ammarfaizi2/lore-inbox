Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVECSNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVECSNf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVECSL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:11:57 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:53632 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261500AbVECSLG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:11:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tGnz0WqiFjzhdr/8W1M1jax44Ov7//D84FwdW5H68bx9QGEAsp/QCJHqbsFrYt+OjB3SxaMGN888VX3qTfxkNunwT0SXA2vwe6Wy4E8RjWCvzLkC9Dwat+64UDrpsClo77rZ0D6m0ssCjBW1tVpAolvzHFbzBuuxFCKjBIGSoYw=
Message-ID: <d6e6e6dd05050311115d256213@mail.gmail.com>
Date: Tue, 3 May 2005 14:11:06 -0400
From: Haoqiang Zheng <haoqiang@gmail.com>
Reply-To: Haoqiang Zheng <haoqiang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: question about contest benchmark
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am wondering how we should interpret the CONTEST benchmark results. 
I tried CONTEST with process_load on 2.6.12-rc3 (single CPU, P4 2.8G,
1G RAM). The CPU usage of kernel compiling is 28.9%, the load consumes
70.1% and the ratio is 3.98.  Based on what Con says, the result is
bad since the ratio is high. I did some tracing and found the
background load (contest) runs at a dynamic priority of 115-120, which
is often higher than the dynamic priority of the kernel compiling
processes. This explains why the process_load consumes so much CPU.
 
 My question is why is the result bad at all? One could certainly
argue that contest processes shouldn't consume so much CPU time since
they are considered to be background jobs. But why is kernel compiling
considered foreground jobs? Why making kernel compiling faster is
better? Actually, I am wondering if CONTEST is an appropriate
benchmark to report system responsiveness at all?
 
 Any comments?
 
 BTW, what benchmark do you guys use to test system responsiveness?
 
  Haoqiang
