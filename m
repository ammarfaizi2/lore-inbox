Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbULUCnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbULUCnt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 21:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbULUCnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 21:43:49 -0500
Received: from web52606.mail.yahoo.com ([206.190.39.144]:38495 "HELO
	web52606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261211AbULUCnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 21:43:47 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=DgmsCMUqL6ivuMEQLxdx3CH/zGSDhD8fBzg/s8iJkcxdnRNMdW3+KRFyt9cT3imYMoGT7i+rB0mG65PUOxAW/nG7TGOYKtxHSIqGv2ipUfPOloMZfA6X/9ZHVsrtrrIRPypwBg1E8ndQdAD8nL0jd45EexEYrvBa2+dtHTkGdGY=  ;
Message-ID: <20041221024347.3004.qmail@web52606.mail.yahoo.com>
Date: Mon, 20 Dec 2004 18:43:47 -0800 (PST)
From: jesse <jessezx@yahoo.com>
Subject: Gurus, a silly question for preemptive behavior
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
As i know, in linux, user space application is
preemptive at any time. however, linux kernel is NOT
preemptive, that means, even some event is finished,
Linux kernel scheduler itself still can't have
opportunity to interrupt the current user application
and switch it out. it is called scheduler latency.
normally , the latency is about 88us in mean , maximum
: 200ms. Thus, the short latency shouldn't impact user
applications too much and is not a problem. It is an
issue in those embedded voice processing systems by
introducing jitters, thus smart people came up with
two kernel schedule patch: preemptive patch and low
latency patch. 

My application which has nice value as 10 of low
priority, however, it holds the CPU and excludes other
applciations that have higher priority (nice 0) to
run, my application causes CPU pegging. 

Thus, I am wondering: why  user space application
can't be effectively interrupted? why there is CPU
pegging?   Could you please educate me 
on this particular issue and shed me some light to
address it? 

my system: 
[root@sa-c2-7 proc]# uname  -a 
Linux sa-c2-7 2.4.21-15.ELsmp #1 SMP Thu Apr 22
00:18:24 EDT 2004 i686 i686 i386 GNU/Linux 

thanks!
