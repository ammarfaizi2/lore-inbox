Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281647AbRKVCIx>; Wed, 21 Nov 2001 21:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282007AbRKVCIo>; Wed, 21 Nov 2001 21:08:44 -0500
Received: from [203.161.228.202] ([203.161.228.202]:59917 "EHLO
	spf1.hq.outblaze.com") by vger.kernel.org with ESMTP
	id <S281647AbRKVCIi>; Wed, 21 Nov 2001 21:08:38 -0500
Date: 22 Nov 2001 02:09:16 -0000
Message-ID: <20011122020916.9909.qmail@yusufg.portal2.com>
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: linux-kernel@vger.kernel.org
Subject: Confused about relationship between tcp_max_syn_backlog and TCP_SYNQ_HSIZE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, According to Documentation/networking/ip-sysctl.txt on 2.4.14

tcp_max_syn_backlog - INTEGER

        Maximal number of remembered connection requests, which are
        still did not receive an acknowledgement from connecting client.
        Default value is 1024 for systems with more than 128Mb of memory,
        and 128 for low memory machines. If server suffers of overload,
        try to increase this number. Warning! If you make it greater
        than 1024, it would be better to change TCP_SYNQ_HSIZE in
        include/net/tcp.h to keep TCP_SYNQ_HSIZE*16<=tcp_max_syn_backlog
        and to recompile kernel.

In include/net/tcp.h. I see the following

#define TCP_SYNQ_HSIZE          512     /* Size of SYNACK hash table
#*/

It seems counterintutive to reduce TCP_SYNQ_HSIZE to 128 if I were to
make tcp_max_syn_backlog to be 2048.

Maybe the documentation is wrong or I haven't figured out the zen in
this. 

Any assistance would be appreciated

Regards, Yusuf

-- 
Yusuf Goolamabbas
yusufg@outblaze.com
