Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWHEVQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWHEVQB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 17:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWHEVQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 17:16:00 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:57964 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030281AbWHEVQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 17:16:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YdvMkO6AIsqzTzpVRJ9piekHaUan9D4D0WOFO/Mor44ZX5HOND5vkFTUlz8UlIOEs3trEXcFqmIlOhuMK4Qe+yQDGWEeBG+1gcPn23fcA35KHEo1o5hlHg4RVVmUtFIFIgl0SvcmcGGELVPtK03UdU8TxUPD3+7NqYBIxgJE21o=
Message-ID: <6bffcb0e0608051415g347ef7b9j3c19a3353697bb5b@mail.gmail.com>
Date: Sat, 5 Aug 2006 23:15:59 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Dave Jones" <davej@redhat.com>,
       "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       "Linus Torvalds" <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
In-Reply-To: <20060805184755.GA25644@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org>
	 <20060805003142.GH18792@redhat.com>
	 <20060805021051.GA13393@redhat.com>
	 <20060805022356.GC13393@redhat.com>
	 <20060805024947.GE13393@redhat.com>
	 <20060805064727.GF13393@redhat.com>
	 <6bffcb0e0608050354k4dd0bb0ep337216e984ce41d7@mail.gmail.com>
	 <6bffcb0e0608050411q22112b71wced519a6491c6abe@mail.gmail.com>
	 <6bffcb0e0608050426s6c39e4f0o57f9093b03c3b27b@mail.gmail.com>
	 <20060805184755.GA25644@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/06, Dave Jones <davej@redhat.com> wrote:
> On Sat, Aug 05, 2006 at 01:26:49PM +0200, Michal Piotrowski wrote:
>
>  > Aug  5 13:18:00 ltg01-fedora kernel: CPU0 called lock_cpu_hotplug()
>  > for app kded. recursive_depth=0
>  > *more snipped traces*
>
> The interesting ones will be the ones before & after you hit that
> BUG: warning at /usr/src/linux-work1/kernel/cpu.c:51/unlock_cpu_hotplug()
> if you can make that happen again.

I don't see nothing interesting before BUG: warning at
/usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()

Only

CPU0 called lock_cpu_hotplug() for app amarokapp. recursive_depth=0
 [<c01329ab>] lock_cpu_hotplug+0x36/0xb9
 [<c01182ce>] sched_getaffinity+0xf/0x83
 [<c0118361>] sys_sched_getaffinity+0x1f/0x41
 [<c0102d51>] sysenter_past_esp+0x56/0x79
amarokapp acquired cpu_bitmask_lock

appears after this warning.

dmesg -> http://www.stardust.webpages.pl/files/2.6-git/18-rc3/dmesg2

>
>                 Dave
>
> --
> http://www.codemonkey.org.uk
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
