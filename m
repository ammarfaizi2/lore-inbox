Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUGMLIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUGMLIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 07:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUGMLIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 07:08:12 -0400
Received: from tristate.vision.ee ([194.204.30.144]:59061 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S264890AbUGMLH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 07:07:59 -0400
Message-ID: <40F3C28C.5070701@vision.ee>
Date: Tue, 13 Jul 2004 14:07:56 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
Organization: Vision
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040705)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Preempt Threshold Measurements
References: <200407121943.25196.devenyga@mcmaster.ca> <20040713024051.GQ21066@holomorphy.com> <200407122248.50377.devenyga@mcmaster.ca> <cone.1089687290.911943.12958.502@pc.kolivas.org> <20040712210107.1945ac34.akpm@osdl.org> <20040713100815.GU21066@holomorphy.com> <20040713104059.GW21066@holomorphy.com>
In-Reply-To: <20040713104059.GW21066@holomorphy.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With all those little patches added and 2.6.8-rc1-ck5 I got this in
my dmesg (preempt=0 voluntary=1 if it makes difference):

bad: ld(3362) scheduling while atomic (1)!
 [<c02797ff>] schedule+0x43f/0x480
 [<c01161a3>] kmap_atomic+0x13/0x70
 [<c0117b5b>] __touch_preempt_timing+0xb/0x30
 [<c0146ef7>] shmem_file_write+0x2f7/0x320
 [<c014d890>] vfs_write+0xb0/0x100
 [<c014d978>] sys_write+0x38/0x60
 [<c0103ee1>] sysenter_past_esp+0x52/0x71
bad: krootimage(3483) scheduling while atomic (1)!
 [<c02797ff>] schedule+0x43f/0x480
 [<c01161a3>] kmap_atomic+0x13/0x70
 [<c0117b5b>] __touch_preempt_timing+0xb/0x30
 [<c0146ef7>] shmem_file_write+0x2f7/0x320
 [<c014d890>] vfs_write+0xb0/0x100
 [<c014d978>] sys_write+0x38/0x60
 [<c0103ee1>] sysenter_past_esp+0x52/0x71

Lenar

William Lee Irwin III wrote:

>That's not quite right. Amazing it didn't catch might_sleep() warnings.
>
>  
>
