Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVFCGct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFCGct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 02:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVFCGct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 02:32:49 -0400
Received: from lns-vlq-17f-81-56-169-232.adsl.proxad.net ([81.56.169.232]:46980
	"EHLO lns-vlq-17f-81-56-169-232.adsl.proxad.net") by vger.kernel.org
	with ESMTP id S261152AbVFCGcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 02:32:46 -0400
Message-ID: <429FF98B.2000505@unice.fr>
Date: Fri, 03 Jun 2005 08:32:43 +0200
From: XIAO Gang <xiao@unice.fr>
Organization: =?ISO-8859-1?Q?Universit=E9_de_Nice_-_Sophia_Anti?=
 =?ISO-8859-1?Q?polis?=
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, fr, zh-CN, zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Need help for sysmask
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could somebody please help me with comments / checks / tests on my 
kernel security patch "sysmask"? See http://wims.unice.fr/sysmask/doc/ 
for documentation and download.

This is a security project designed to allow set up systems that 
tolerate (controlled) executions of arbitrary malicious codes without 
being hurt. In practice, this means that the majority of current 
security updates due to vulnerabilities in software, library or even 
parts of the kernel will become unnecessary.

The code is now much stabilized after several weeks of intensive test on 
a busy server (http://wims.unice.fr/), including a demo challenge page 
(http://wims.unice.fr/wims/wims.cgi?module=adm/unice/challenge) that has 
been bombarded with all sorts of tricks. The server runs on a patched 
2.4.29, SMP-enabled but there is only one cpu in the hardware.

Sysmask is rather ready for a 1.00 release. But before doing so, it 
would be great if the following problem could be solved with your help.

1. I hope that somebody can give it a test on other hw/sw configurations 
with result feedback, especially for the 2.6 kernel versions and 
hopefully on a true SMP with a good load level.

It would be best if some tests could be done with full activation of the 
protection. For this some manual editing of the default sysmask 
configuration files would be necessary. But this should be quite 
straightforward, and the footprint of sysmask on an existing system is 
strictly minimal, with only one file (/etc/inittab) that needs to be 
modified in order to fully activate it.

2. Although I am not planning to submit the patch to the official kernel 
immediately, it would like to be able to make it more conform to the 
kernel standards and conventions. Among others, I need your help to 
solve some known problemes, the biggest being squatting an existing 
syscall number (sys_mpx). Of course this is just a temporary solution, 
due to the fact that I don't know how to get a permanent one.

3. Another example is that the current patch adds a few hundred bytes 
(200-300) to the size of task_struct. Is this potentially a problem, 
should it be moved to a page allocation?

Please give me a cc if you reply to this message; I am not constantly following the list.

-- 

XIAO Gang (~{P$8U~})                          xiao@unice.fr
          home page: pcmath126.unice.fr/xiao.html 



