Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTK2GOm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 01:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTK2GOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 01:14:42 -0500
Received: from gw-undead3.tht.net ([216.126.84.18]:45184 "HELO mail.undead.cc")
	by vger.kernel.org with SMTP id S263691AbTK2GOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 01:14:40 -0500
Message-ID: <3FC8394A.7010702@undead.cc>
Date: Sat, 29 Nov 2003 01:14:34 -0500
From: John Zielinski <grim@undead.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Rootfs mounted from user space - problem with umount
References: <3FC82D8F.9030100@undead.cc> <20031129053128.GF8039@holomorphy.com>
In-Reply-To: <20031129053128.GF8039@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>
>Could you do a sysrq t and send in a backtrace?
>
>  
>
Here's the trace for umount:

umount        D DF9D98C0  3920   380    245                     (NOTLB)
def55f18 00000086 c015be66 df9d98c0 dffe0900 def55f3c c0169f59 def55f00
       def55f00 def55ef8 00108291 0c4cb8db 00000042 df0ec6a0 dffe2640 00000002
       df0ec6a0 def55f44 c01e169c dffe0900 dffe2644 dffe2644 dffe2644 df0ec6a0
Call Trace:
 [<c015be66>] path_release+0x16/0x40
 [<c0169f59>] umount_tree+0xa9/0x100
 [<c01e169c>] rwsem_down_write_failed+0x8c/0x140
 [<c0155e0b>] .text.lock.super+0x12/0x187
 [<c016a22c>] sys_umount+0x3c/0x90
 [<c016a299>] sys_oldumount+0x19/0x20
 [<c010938f>] syscall_call+0x7/0xb


I'm running the 2.6.0-test9 kernel.

John



