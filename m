Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbUBYPTb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUBYPTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:19:31 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:10127 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261352AbUBYPT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:19:29 -0500
Message-ID: <403CBCE6.7040405@nortelnetworks.com>
Date: Wed, 25 Feb 2004 10:19:02 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/mounts "stuff"
References: <Pine.LNX.4.53.0402241630500.4054@chaos>
In-Reply-To: <Pine.LNX.4.53.0402241630500.4054@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Linux version 2.2.24 (actually since pivot-root), have a
> problem with what's in /proc/mounts vs. what's written
> to /etc/mtab when mounting file-systems.
> 
> /etc/mtab
> 
> /dev/sda1 / ext2 rw 0 0
> none /proc proc rw 0 0
> none /dev/pts devpts rw,gid=5,mode=620 0 0
> none /dev/shm tmpfs rw 0 0
> /dev/sdb1 /usr/src ext2 rw 0 0
> 
> /proc/mounts
> 
> rootfs / rootfs rw 0 0
> /dev/root / ext2 rw 0 0

The shutdown scripts on my system seem to be compensating for this. 
However, I'm hitting another problem where I do a pivot_root to a tmpfs 
filesystem and the shutdown scripts no longer know how to deal with it 
and try to unmount the real root filesystem from under themselves, 
causing all kinds of problems.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
