Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264277AbUEMQPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbUEMQPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 12:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbUEMQPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 12:15:46 -0400
Received: from j110113.ppp.asahi-net.or.jp ([61.213.110.113]:28428 "EHLO
	mail.tar.bz") by vger.kernel.org with ESMTP id S264277AbUEMQPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 12:15:45 -0400
Message-ID: <40A39F2E.2080303@ThinRope.net>
Date: Fri, 14 May 2004 01:15:42 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Pascal Schmidt <der.eremit@email.de>
Subject: Re: Too restrictive permissions on some files prevent non-root build
  (with KBUILD_OUTPUT) [bug 2669]
References: <1VorQ-6xx-13@gated-at.bofh.it> <E1BOGcs-00006u-7d@localhost>
In-Reply-To: <E1BOGcs-00006u-7d@localhost>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Schmidt wrote:
> On Thu, 13 May 2004 15:30:14 +0200, you wrote in linux.kernel:
> 
>>For 2.6.6 the files in question can be found by:
>>cd /sometempdir
>>tar xjf linux-2.6.6.tar.bz2
>>find linux-2.6.6 ! -perm -004 -exec ls -l {} \;
> 
> 
> This can only be a problem when unpacking as root, otherwise all
> files are owned by the user running tar, anyway. I guess most
> people don't do their kernel work as root... and why should they?
> 
> The simple workaround is to unpack the tar archive as the user
> planning to run the compile.
> 

Well, I guess you are right, but I prefer (and usually do) a single source tree in /usr/src/linux-2.6.6 as for the kurrent kernel and then other users (i.e. non root) compile with the KBUILD_OUTPUT in other directories.

Why?

Because I compile all my kernels on a single machine (but with distcc running on 4+ boxes) and then install it on the other machines.

Even if these file permissions are note a "real bug" there is no point in only some files being non-world readable (some in the Documentation/ as well).

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
