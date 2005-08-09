Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVHIJX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVHIJX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVHIJX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:23:27 -0400
Received: from burnt-tech.com ([66.98.218.53]:17049 "HELO burntmail.com")
	by vger.kernel.org with SMTP id S932480AbVHIJX0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:23:26 -0400
From: "vinay" <vinays@burntmail.com>
To: "Xavier Roche" <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org
Importance: Normal
Sensitivity: Normal
Message-ID: <W7860621974246141123579405@burntmail>
X-Mailer: Mintersoft VisualMail, Build 4.0.111601
X-Originating-IP: [203.200.200.70]
Date: Tue, 09 Aug 2005 09:23:25 +0000
Subject: Re:  Kernels Out Of Memoy(OOM) killer Problem ?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xavier.

Thanks for replying.
I checked that the /proc/sys/vm/overcommit_memory is already set to 0.

In my case the problem is that I don't have many options like changing
the overcommit_memory etc.
Only thing I need to do is, have a proper cleanup will exiting the application.  As the application is receiving SIKILL from OMM killer the required signal handler is not getting called and no cleanup is happening.
So could you please suggest me that what could be done in this regard.

Thanks and Regards

Vinay.

> -----Original Message-----
> From: Xavier Roche [mailto:roche+kml2@exalead.com]
> Sent: Tuesday, August 9, 2005 08:06 AM
> To: linux-kernel@vger.kernel.org
> Subject: Re: Kernels Out Of Memoy(OOM) killer Problem ?
> 
> vinay wrote:
> > I have a problem with linux kernel's Out Of Memory (OOM) killer.
> > I wanted to know, is there any way that we can force OOM killer to send a signal other than SIGKILL to kill a process when ever OOM detects a system memory crunch. 
> 
> As far as I understand the kernel, oom is called when the system has no
> memory pages left, and MUST get one to continue normal (ie. kernel)
> processing. The kernel just do not have the time to execute some
> user-space code, it MUST get free pages where they are (and hence, kill
> immediately some innocent process).
> 
> This condition should not occur without using overcommit. Are you sure
> you are not using overcommit ? (cat /proc/sys/vm/overcommit_memory)
> 
> To dasable it:
> echo 0 > /proc/sys/vm/overcommit_memory
> 
> Overcommit is quite dangerous on production systems, because it leads to
> oom kills on heavy loads (at least, this is what I experienced).
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


