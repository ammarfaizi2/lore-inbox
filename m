Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbRDIFEF>; Mon, 9 Apr 2001 01:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132692AbRDIFDq>; Mon, 9 Apr 2001 01:03:46 -0400
Received: from quechua.inka.de ([212.227.14.2]:26176 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S132691AbRDIFDh>;
	Mon, 9 Apr 2001 01:03:37 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: race condition on looking up inodes
In-Reply-To: <000201c0c0a4$eb5c7b10$321ea8c0@saturn>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14mTpv-0002Qv-00@sites.inka.de>
Date: Mon, 9 Apr 2001 07:03:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <000201c0c0a4$eb5c7b10$321ea8c0@saturn> you wrote:
>    rename("/usr/hybrid/cfg/data","/usr/mytemp/data1"); /*for process 1*/
>  rename("/usr/mytemp/data1","/usr/test");/* for process 2*/

Rename syscall is expected to be atomic on unixoid systems. And I dont know of
a case where a problem is, besides if you use some network file system, where
nobody can realy gurantee anything (well kidding, but it is harder than on a
local one).

The second rename may see the result of the first rename or the original state
before the first rename. It will not see any half-state or locked nodes.

Greetings
Bernd
