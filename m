Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVAVRS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVAVRS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 12:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVAVRS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 12:18:58 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:3691 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261414AbVAVRSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:18:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=d/hq9rGcuiBvdTmyin5c+m3aFfXSJT8PmR39l0YGkWYm8a2UL8punroqM/Qn0PSylAz1qxp1cca6W/b/dCt0yUpfEUpnUjyHzS/DY+a93xtchjaJVswirWp6V8UlVaXA40r7phGKAebCcAA7Mask1Tq+/GJavS5IdsoPnFREbqA=
Message-ID: <5a4c581d050122091829a64f29@mail.gmail.com>
Date: Sat, 22 Jan 2005 18:18:55 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a threading error
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <217740000.1106412985@10.10.2.4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <217740000.1106412985@10.10.2.4>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2005 08:56:25 -0800, Martin J. Bligh <mbligh@aracnet.com> wrote:
> Please contact bug submitter for more info, not myself.
> 
> ---------------------------------------------
> 
> http://bugme.osdl.org/show_bug.cgi?id=4081
> 
>            Summary: OpenOffice crashes while starting due to a threading
>                     error
>     Kernel Version: 2.6.11-rc2
>             Status: NEW
>           Severity: blocking
>              Owner: process_other@kernel-bugs.osdl.org
>          Submitter: diego@pemas.net
> 
> Distribution: Debian
> Hardware Environment: Pentum III 733 MHz
> Software Environment: Debian Sid
> Problem Description:
> While starting open Office crashes, it did not happend on 2.6.10, but happend on
> 2.6.11. rc1 and rc2. The only thing that has changed is the kernel. If i go back
> to 2.6.10 OpenOffice starts just fine.
> 
> gdb shows that it crashes during this call:
> thread_get_info_callback: cannot get thread info: generic error
> 
> the logs kern.log and messages don't show anything related to this crash.
> 
> Steps to reproduce:
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Doesn't happen here:

[asuardi@incident asuardi]$ grep openoffice /var/log/rpmpkgs
openoffice.org-1.1.2-11.4.fc2.i386.rpm
openoffice.org-i18n-1.1.2-11.4.fc2.i386.rpm
openoffice.org-libs-1.1.2-11.4.fc2.i386.rpm
[asuardi@incident asuardi]$ cat /proc/version
Linux version 2.6.11-rc1-bk9 (asuardi@incident) (gcc version 3.4.3) #1
Fri Jan 21 15:46:16 CET 2005

Will try -rc2 later...

--alessandro
 
 "And every dream, every, is just a dream after all"
  
    (Heather Nova, "Paper Cup")
