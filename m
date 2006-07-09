Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWGILCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWGILCu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 07:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWGILCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 07:02:50 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:45750 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932440AbWGILCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 07:02:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PflvCvN6JK59eXNeJ4lFWBv/Krd1uTLSSncbcFHwgfGmmsQiUEDb5zMKf9smQk+aSmsQgS8/j+VLj6Zy4f5ccC8Xq2NSnFhQBxFQnazhml6Qs4GIqfEnePh0UBirFwvL7DJnRtJzl99/MCVrtoj4ue1QTuKVTO4YiTY6q7ynRds=
Message-ID: <6bffcb0e0607090402m1f6c09c7hc9abc380bf36d460@mail.gmail.com>
Date: Sun, 9 Jul 2006 13:02:48 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060709021106.9310d4d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060709021106.9310d4d1.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
>

LTP hangs on

<<<test_output>>>
setrlimit01    1  PASS  :  RLIMIT_NOFILE functionality is correct
setrlimit01    0  WARN  :  caught signal 2, not SIGSEGV
<<<execution_status>>>
duration=1071 termination_type=driver_interrupt termination_id=1 corefile=no
cutime=0 cstime=1
<<<test_end>>>

[michal@ltg01-fedora linux-mm]$ ps aux | grep setr
root      5155 99.1  0.0   1612   188 pts/0    R    12:39  20:30 setrlimit01

sudo kill -9 5155

[michal@ltg01-fedora linux-mm]$ ps aux | grep setr
root      5155 99.0  0.0   1612   188 pts/0    R    12:39  20:57 setrlimit01

unkillable process? I'll try to strace this.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
