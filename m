Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWJMRuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWJMRuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWJMRuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:50:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:22198 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751507AbWJMRuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:50:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=st2NKtIlku+HnGRjZbkG72F9xWWh5XPOAnhvaTvgBe0y8ee2yd4EHqHrFHitFQYt018ACTumk4F00dpMGq6xodLqrPBaT7i5DkLD+Va1QGinjcJf+nhE3r7x07toJhSBIG8XRtpEKY0Vg/SEzlkKORexuWiuZtsNQ7+9AplIM28=
Message-ID: <28bb77d30610131050l6501957oc43b5be2be8bf289@mail.gmail.com>
Date: Fri, 13 Oct 2006 10:50:08 -0700
From: "Steven Truong" <midair77@gmail.com>
To: vgoyal@in.ibm.com
Subject: Re: kdump/kexec/crash on vmcore file
Cc: linux-kernel@vger.kernel.org, crash-utility@redhat.com,
       "Dave Anderson" <anderson@redhat.com>
In-Reply-To: <20061013141446.GA27375@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <28bb77d30610121450n6cfd9c6ejd6b0370d2400a378@mail.gmail.com>
	 <20061013141446.GA27375@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vivek.  Thank you very much for the tips.  I went back to check my
command to load the crash/capture kernel and found out that I loaded
the wrong kernel.  I then tried again with the correct kernel and now
I was able to use crash to analyze the vmcore kdump file.

Thank you once again.

On 10/13/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> On Thu, Oct 12, 2006 at 02:50:33PM -0700, Steven Truong wrote:
> > Hi, all.  This is my first attempt to troubleshoot a kernel panic so I
> > am quite newbie in this area. I have been able to obtain a kdump when
> > my box had kernel panic.
> >
> > I set up Kdump and Kexec and then the captured/crash kernel to boot
> > into Level 1 and then copy /proc/vmcore file to the disk for later
> > analysis.  However, after the server booted back to Level 3 and I
> > utilized the crash command to analyzed the vmcore file.  I got error
> > message:
> >
> > ./crash /boot/vmlinux ../vmcore.test
> >
> >
> > crash: read error: kernel virtual address: ffffffff8123d1e0  type:
> > "kernel_config_data"
> > WARNING: cannot read kernel_config_data
> > crash: read error: kernel virtual address: ffffffff813b5180  type: "xtime"
> >
>
> Hi Steven,
>
> which vmlinux are you using for analysis? First kernel's vmlinux or
> second kernel's vmlinux. You should be using first kernel's vmlinux.
>
> crash is trying to read some symbols from the core file and crash thinks
> that virtual address for kernel_config_data is ffffffff8123d1e0. I think
> this is too high a address. I guess this will be the address if you
> compile your kernel for physical address 16MB. So my first guess is that
> you are using second kernel's vmlinux for analysis.
>
> Which kernel version and kexec-tools version are you using?
>
> I am also copying the mail to crash-utility mailing list where folks
> keep a watch on crash related issues.
>
> Thanks
> Vivek
>
