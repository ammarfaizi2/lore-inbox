Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbTDNEGC (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 00:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTDNEGC (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 00:06:02 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:49680 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP id S262733AbTDNEGB (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 00:06:01 -0400
From: Tim Connors <tconnors@astro.swin.edu.au>
Message-Id: <200304140417.h3E4Hkh27135@tellurium.ssi.swin.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67: ppa driver & preempt == oops
In-Reply-To: <20030413201011$5dde@gated-at.bofh.it>
References: <20030413201011$1026@gated-at.bofh.it> <20030413201011$250d@gated-at.bofh.it> <20030413201011$5dde@gated-at.bofh.it>
Date: Mon, 14 Apr 2003 14:17:46 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, you wrote:
> Andrew Morton wrote:
>> Gert Vervoort <gert.vervoort@hccnet.nl> wrote:
>> 
>>>ppa: Version 2.07 (for Linux 2.4.x)
>>>ppa: Found device at ID 6, Attempting to use EPP 16 bit
>>>ppa: Communication established with ID 6 using EPP 16 bit
>>>scsi0 : Iomega VPI0 (ppa) interface
>>>bad: scheduling while atomic!
>> 
>> 
>> This patch should make the warnings go away.
>> 
>> I've been sitting on it for a while, waiting for someone to tell me if the
>> ppa driver actually works.  Perhaps that person is you?
> 
> I've responded to your questions more than once but evidently you
> haven't seen or been able to parse my responses.
> 
> To recap:  I see a non-fatal kernel-oops and modprobe segfaults after
> successfully loading the ppa module.  Once the ppa module is loaded the
> ppa driver actually does work with 2.5.x for at least x>50 (I haven't 
> tried x<50).
> 
> I am using preemptable kernel and devfs and I do NOT see any of the
> warnings that Geert is seeing.  The only problems I see with Linus's
> 2.5.x kernels is the segfault by modprobe, not with the function of
> ppa itself.

I'm using both devfs and preempt. The first time I booted (I think it
was actually 2.5.66), I tried to mount /zip, and it hung, with 100%
cpu usage after that (I can't rememebr what process), and several
traces in syslog (lsmod showed the modules as loaded, I think one or
two of them "unsafe"). Next time I booted (2.5.67+V4L patches), I
modprobed ppa manually, this time, it segfaulted (with traces in
syslog), but the modules were listed in lsmod correcly. I then
mounted, and it was fine.

Sorry I don't have the logs with me, one of the drawbacks of being too
cheap to afford a home innernet connection :(


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

Press any key to continue, any other key to abort
           -- thrillbert's code
