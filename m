Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVEKGGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVEKGGH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 02:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVEKGGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 02:06:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:39599 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261901AbVEKGGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 02:06:00 -0400
Date: Wed, 11 May 2005 11:34:34 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: coywolf@lovecn.org
Cc: Borislav Petkov <petkov@uni-muenster.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kexec?
Message-ID: <20050511060434.GA8856@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20050508202050.GB13789@charite.de> <20050509183428.6d7934a6.rddunlap@osdl.org> <2cd57c9005051000004c57050@mail.gmail.com> <200505101215.48993.petkov@uni-muenster.de> <2cd57c9005051006117d0c343@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c9005051006117d0c343@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 09:11:31PM +0800, Coywolf Qi Hunt wrote:
> On 5/10/05, Borislav Petkov <petkov@uni-muenster.de> wrote:
> > I've been doing some kexec tests (as described in Documentation/kdump.txt) too
> > but can't get to load the image and get similar error messages. Let me know
> > if you need more info about the hardware. The first_kernel was booted with
> > "crashkernel=64M@16M" and the 16M value was configured into the second during
> > kconfig in "Physical address where the kernel is loaded" as 0x1000000.
> > 
> > [root@zmei]: kexec -p vmlinux --args-linux --append="root=/dev/hda1 maxcpus=1
> > init 1"
> 
>  kexec-tools-1.101 loads for me, but if cmdline is used, it hangs up
> after "Starting new kernel"

Thanks for trying this out. As Vivek mentioned can you please try with bulding
second or dump capture kernel with CONFIG_SMP=N and _without_ maxcpus= option. 
Basically the second kernel's job is just to save the dump and it doesnot need 
to be a SMP kernel. There are some issues with booting SMP kernel as dump 
capture kernel.

Also, it would be great help if you can also send us some hardware details
about the system you are trying, like lspci, /proc/cpuinfo and which kernel
you tried. I am maintaining a webpage to consolidate the test reports of kexec/kdump
at 
http://lse.sourceforge.net/kdump/kdump-test.html

Thanks
Maneesh



-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
