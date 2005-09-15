Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbVIOBjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbVIOBjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbVIOBjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:39:05 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30895 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030329AbVIOBjE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:39:04 -0400
Message-ID: <4328D0A8.90504@in.ibm.com>
Date: Wed, 14 Sep 2005 20:38:48 -0500
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
CC: Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       patrics@interia.pl, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
References: <20050915005552.38626180A1A@magilla.sf.frob.com>
In-Reply-To: <20050915005552.38626180A1A@magilla.sf.frob.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:
>>If you don't like this idea at all, please let me know if there any other 
>>way of solving the invisible threads problem, short of taking out 
>>->permission() altogether from proc_task_inode_operations.
> 
> 
> Have you investigated my suggestion to move __exit_fs from do_exit to
> release_task?

Roland,

No, I had missed this completely. Sorry.

I just gave it a quick try and it seems to be working fine. I have only 
moved __exit_fs to the top of release_task, not moved exit_namespace after 
it. I will try to run some tests to see if this is working fine. Thanks a lot.

Thanks and regards,
Sripathi.
