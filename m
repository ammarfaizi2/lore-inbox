Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVAQTzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVAQTzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVAQTzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:55:41 -0500
Received: from quark.didntduck.org ([69.55.226.66]:50581 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262858AbVAQTzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:55:35 -0500
Message-ID: <41EC1853.2070107@didntduck.org>
Date: Mon, 17 Jan 2005 14:56:03 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Bookholt <kavefish@kavefish.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 Series Mem Mgmt
References: <g7Idbr9m.1105713630.9207120.khali@localhost>	<200501151654.46412.pioppo@ferrara.linux.it>	<20050115175545.743a39f9.khali@linux-fr.org>	<200501162332.14324.pioppo@ferrara.linux.it> <20050117201901.3e712cfa.khali@linux-fr.org> <41EC1406.6040500@kavefish.net>
In-Reply-To: <41EC1406.6040500@kavefish.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Bookholt wrote:
> I'm hoping someone can help explain part of the layout of a process' 
> virtual address space in the 2.6 series kernel.
> 
> Below is the output of "cat /proc/self/maps" on Fedora Core 3 
> (2.6.9-1.6_FC2) with exec-shield[-randomize] disabled and 
> legacy_vm_layout enabled.
> 
> What is being mapped in at last line (ffffe000-fffff000 ---p)?  This is 
> always there, no matter what process I run.  To my knowledge, this 
> wasn't the case on 2.4.
> 
>  >$ cat /proc/self/maps
> 08048000-0804c000 r-xp 00000000 03:03 2490451    /bin/cat
> 0804c000-0804d000 rw-p 00003000 03:03 2490451    /bin/cat
> 0804d000-0806e000 rw-p 0804d000 00:00 0
> 42344000-42359000 r-xp 00000000 03:03 950351     /lib/ld-2.3.3.so
> 42359000-4235a000 r--p 00014000 03:03 950351     /lib/ld-2.3.3.so
> 4235a000-4235b000 rw-p 00015000 03:03 950351     /lib/ld-2.3.3.so
> 4235d000-42473000 r-xp 00000000 03:03 950450     /lib/tls/libc-2.3.3.so
> 42473000-42474000 r--p 00116000 03:03 950450     /lib/tls/libc-2.3.3.so
> 42474000-42477000 rw-p 00117000 03:03 950450     /lib/tls/libc-2.3.3.so
> 42477000-42479000 rw-p 42477000 00:00 0
> 55017000-55018000 rw-p 55017000 00:00 0
> 55018000-55218000 r--p 00000000 03:03 114690 /usr/lib/locale/locale-archive
> feffe000-ff000000 rw-p feffe000 00:00 0
> ffffe000-fffff000 ---p 00000000 00:00 0
> 
> I have not had much success in my search for information via Google & 
> IRC and the books I have are specific to the 2.4 series.  Any help would 
> be greatly appreciated.
> 

That is the vsyscall page.

--
				Brian Gerst
