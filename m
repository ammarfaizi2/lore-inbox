Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbULMMc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbULMMc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbULMMc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:32:28 -0500
Received: from alog0083.analogic.com ([208.224.220.98]:14464 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262243AbULMMcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:32:24 -0500
Date: Mon, 13 Dec 2004 07:31:07 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Zhenyu Wu <y030729@njupt.edu.cn>
cc: linux-kernel@vger.kernel.org
Subject: Re: about kernel_thread!
In-Reply-To: <302943559.21891@njupt.edu.cn>
Message-ID: <Pine.LNX.4.61.0412130726060.30037@chaos.analogic.com>
References: <302943559.21891@njupt.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Zhenyu Wu wrote:

> Hello,
>
> I have some confusions on kernel_thread, so I want to get help.
>
> I want to create a thread in a loadable module, then I used the function
> kernel_thread() in init_module(). Of course, the thread was created, but when I
> remove the module there are errors. I think it is because of the thread I have
> created that have not been killed. So, how can I kill this thread when I remove
> the module?
>
> Thanks,
>

You copy the method used in other kernel modules. This involves
a semaphore and having the module removing routine send the task
a signal. FYI, there is a wait_for_completion() routine and a
complete_and_exit() routine already defined.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
