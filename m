Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSDIFgs>; Tue, 9 Apr 2002 01:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSDIFgr>; Tue, 9 Apr 2002 01:36:47 -0400
Received: from quechua.inka.de ([212.227.14.2]:28534 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S288748AbSDIFgr>;
	Tue, 9 Apr 2002 01:36:47 -0400
From: Bernd Eckenfels <ecki-news2002-03@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: system call for finding the number of cpus??
In-Reply-To: <20020408221223.GE13043@werewolf.able.es>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16uoJE-00087t-00@sites.inka.de>
Date: Tue, 9 Apr 2002 07:36:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020408221223.GE13043@werewolf.able.es> you wrote:
> On 2002.04.08 "Kuppuswamy, Priyadarshini" wrote:
>>I don't think that (sysconf(_SC_NPROCESSORS_CONF)) command works on linux. It works on Unix. I tried that. It returns 1 when there are 4 processors on linux.
>>

> Tried and works. get_nproc_conf and _SC_NPROCESSORS_CONF work the same.

Using "strace getconf _NPROCESSORS_CONF" it tells me, that glibc is also
parsing /proc/cpuinfo.

BTW: there are _NPROCESSORS_CONF and _NPROCESSORS_ONLN, works for me:

3ecki@calista:~> getconf _NPROCESSORS_CONF
1
3ecki@calista:~> getconf _NPROCESSORS_ONLN
1
ecki@SeeDeBrCVS:~$ getconf _NPROCESSORS_CONF
2
ecki@SeeDeBrCVS:~$ getconf _NPROCESSORS_ONLN
2

Greetings
Bernd
