Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266602AbUAWROM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUAWROM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:14:12 -0500
Received: from tristate.vision.ee ([194.204.30.144]:31179 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S266602AbUAWROJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:14:09 -0500
Message-ID: <4011565B.1030304@vision.ee>
Date: Fri, 23 Jan 2004 19:14:03 +0200
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040111 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Badness in futex_wait 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Don't now if this is useful or indicates any possible problems at all, 
but found this in kern.log:

Jan 20 18:33:30 horizon kernel: Badness in futex_wait at kernel/futex.c:509
Jan 20 18:33:31 horizon kernel: Call Trace:
Jan 20 18:33:31 horizon kernel:  [futex_wait+414/416] futex_wait+0x19e/0x1a0
Jan 20 18:33:31 horizon kernel:  [default_wake_function+0/32] 
default_wake_function+0x0/0x20
Jan 20 18:33:31 horizon kernel:  [default_wake_function+0/32] 
default_wake_function+0x0/0x20
Jan 20 18:33:31 horizon kernel:  [do_futex+112/128] do_futex+0x70/0x80
Jan 20 18:33:31 horizon kernel:  [sys_futex+268/304] sys_futex+0x10c/0x130
Jan 20 18:33:31 horizon kernel:  [sysenter_past_esp+67/101] 
sysenter_past_esp+0x43/0x65

2.5 days later machine hanged (but propably due to being nForce2 based).

Kernel version: 2.6.1-rc1-mm1

Lenar
