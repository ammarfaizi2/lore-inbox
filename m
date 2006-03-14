Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWCNR3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWCNR3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWCNR3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:29:03 -0500
Received: from smtpout.mac.com ([17.250.248.45]:47071 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751350AbWCNR3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:29:01 -0500
In-Reply-To: <200603141216.23335.gene.heskett@verizon.net>
References: <200603140901.27746.cijoml@volny.cz> <20060314083812.GA27338@brainysmurf.cs.umu.se> <4416DBC2.8000103@cfl.rr.com> <200603141216.23335.gene.heskett@verizon.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <644428B9-6AE0-40D4-A7CE-F4C6540F0F69@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>,
       Phillip Susi <psusi@cfl.rr.com>, CIJOML <cijoml@volny.cz>,
       Peter Hagervall <hager@cs.umu.se>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Dmesg is not showing whole boot list
Date: Tue, 14 Mar 2006 12:28:49 -0500
To: Gene Heskett <gene.heskett@verizononline.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 14, 2006, at 12:16:23, Gene Heskett wrote:
> On Tuesday 14 March 2006 10:05, Phillip Susi wrote:
>> Or look in your /var/log/kern.log file instead of asking dmesg.   
>> dmesg just dumps the kernel ring buffer which is of finite size.   
>> The entire contents should be logged to /var/log/kern.log.
>
> You've got to have /var checked and mounted to be able to do that  
> log write, if the buffer overflows before that, then the head end  
> of the dmesg dump to the /var/log/dmesg file is lost forever.
>
> There is a line that can be changed, in xconfig or by hand, to  
> control the memory allocated for this ring buffer.
>
> Finally found it in the xconfig display, left panel line=kernel  
> hacking, right panel its under kernel debugging and shows only if  
> thats checked, double click on the line that says : kernel log  
> buffer size and enter a one digit increment from whats there now,  
> maybe 2, I have mine set for 16.  Your default may be as low as 14,  
> why I have NDI because 16k sure as heck isn't enough if something  
> gets chatty.

To continue this point; on my desktop I have root/var/tmp/vicepa-on- 
LVM-on-RAID5, boot-on-RAID1, and swap-on-RAID1, so I would easily  
overflow the default SMP dmesg buffer size in messages well before  
syslogd/bootlogd got started.  I finally ended up having to increment  
the default by 3 in order to have the boot messages still available  
after booting.  It would be nice if we could quiet down some of the  
more excessively verbose kernel messages, there's a lot of mostly- 
irrelevant spew that chews up log buffer space.

Cheers,
Kyle Moffett
