Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVCSJIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVCSJIk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 04:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVCSJIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 04:08:40 -0500
Received: from smartmx-03.inode.at ([213.229.60.35]:4322 "EHLO
	smartmx-03.inode.at") by vger.kernel.org with ESMTP id S261982AbVCSJIi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 04:08:38 -0500
Message-ID: <423BEC0E.300@inode.info>
Date: Sat, 19 Mar 2005 10:08:30 +0100
From: Richard Fuchs <richard.fuchs@inode.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc/$pid/mem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aloha!

I know it has been discussed before, but I must express my feelings 
about this issue nonetheless. I find it a major pain in the back that 
/proc/$pid/mem isn't readable by an unrelated process without doing a 
PTRACE_ATTACH first.

I mainly want to ask: is there a good reason to not drop this restriction?

I can read all the machine's physical memory and all of the kernel's 
address space (/dev/mem, /proc/kcore) non-intrusively, but I can't do 
the same on a single process. It seems to me that /proc/$pid/mem should 
work analogous to /dev/mem or /proc/kcore, but currently in practice it 
doesn't, and I don't see a good reason why it is supposed to be that way.

Cheers
Richard
