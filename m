Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292270AbSB0Iom>; Wed, 27 Feb 2002 03:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292275AbSB0Ioc>; Wed, 27 Feb 2002 03:44:32 -0500
Received: from gw.sp.op.dlr.de ([129.247.188.16]:11664 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S292270AbSB0IoT>;
	Wed, 27 Feb 2002 03:44:19 -0500
Message-ID: <3C7C9C41.5080400@dlr.de>
Date: Wed, 27 Feb 2002 09:43:45 +0100
From: Martin Wirth <Martin.Wirth@dlr.de>
Reply-To: Martin.Wirth@dlr.de
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:0.9.4) Gecko/20011206 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: frankeh@watson.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semphores
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hubertus,

I just had a quick look on your semaphore code. As far as I can see you 
do no re-check of the userspace semaphore counter while going to sleep 
on your kernel semaphore. But this way you may loose synchronization 
between the kernel semaphore and the user-space semaphore counter if 
more than two processes are involved. Or did I miss some tricky form
of how you avoided this problem?

Martin Wirth

