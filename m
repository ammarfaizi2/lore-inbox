Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264740AbTE1QTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264793AbTE1QTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:19:46 -0400
Received: from [193.112.238.6] ([193.112.238.6]:50053 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S264740AbTE1QTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:19:45 -0400
Message-ID: <3ED4E4BB.10806@xisl.com>
Date: Wed, 28 May 2003 17:32:59 +0100
From: John M Collins <jmc@xisl.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about memory-mapped files
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc me (jmc@removespam.xisl.com) in any reply as I'm not subscribed.

Could someone advise me on the answer to the following question:

If I invoke mmap to map a file to memory, and it succeeds, can I safely 
close the original file descriptor and rely on the memory still being 
mapped and the file still updated (possibly with mysnc)?

I've looked through the kernel (2.4) source and it seems I can. I've 
tried a test program on my machine and also Solaris and HP and it works 
OK the file getting updated.

On the Linux machine /proc/<pid>/maps seems to have all the right stuff 
in after the file is closed.

The only thing that doesn't happen is that the file mod time doesn't get 
changed (on any machine).

Of course "munmap" and "mremap" don't oblige you to pass an fd so it 
would seem logical. But no manual page actually seems to say it.

Could anyone advise? Thanks.

-- 
John Collins Xi Software Ltd www.xisl.com


