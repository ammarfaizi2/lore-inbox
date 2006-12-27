Return-Path: <linux-kernel-owner+w=401wt.eu-S932881AbWL0Clm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881AbWL0Clm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 21:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932889AbWL0Clm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 21:41:42 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:59425 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932881AbWL0Clm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 21:41:42 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 21:41:41 EST
From: Askadar <askadar@hvk-gymnasium.de>
To: linux-kernel@vger.kernel.org
Subject: RE: linux tcp stack behavior change
Date: Tue, 26 Dec 2006 21:34:11 -0500
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612262134.11609.askadar@hvk-gymnasium.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However, I know that plain -sF worked with previous kernels. Using
> nmap-4.00 on 2.6.18.5 yields the same result, so I do not think it is
> caused by a change in nmap code. Could someone with 2.6.13-2.6.17 verify
> that the TCP stack returned a RST?

Works for me on 2.6.18.3:

[root@DS-12 bb]# tcpdump -ni lo &
[root@DS-12 bb]# nmap localhost -n -sX -p 22

Starting Nmap 4.11 ( http://www.insecure.org/nmap/ ) at 2006-12-26 21:26 EST
21:26:09.217187 IP 127.0.0.1.46872 > 127.0.0.1.22: FP 4139391634:4139391634(0) 
win 1024 urg 0
21:26:09.217355 IP 127.0.0.1.22 > 127.0.0.1.46872: R 0:0(0) ack 4139391635 win 
0
Interesting ports on 127.0.0.1:
PORT   STATE  SERVICE
22/tcp closed ssh

[root@DS-12 bb]# uname -a
Linux DS-12 2.6.18-ARCH #1 SMP PREEMPT Sun Nov 19 09:14:35 CET 2006 i686 
Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz GenuineIntel GNU/Linux

[root@DS-12 bb]# pacman -Q kernel26
kernel26 2.6.18.3-1

- Björn
