Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVELGm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVELGm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 02:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVELGm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 02:42:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:52196 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261170AbVELGmv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 02:42:51 -0400
Date: Thu, 12 May 2005 12:11:19 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, coywolf@lovecn.org,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kexec?
Message-ID: <20050512064119.GA3870@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20050508202050.GB13789@charite.de> <2cd57c9005051006117d0c343@mail.gmail.com> <20050511060434.GA8856@in.ibm.com> <200505111351.42266.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505111351.42266.petkov@uni-muenster.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 01:51:41PM +0200, Borislav Petkov wrote:
> On Wednesday 11 May 2005 08:04, Maneesh Soni wrote:
> <snip>
> > > > [root@zmei]: kexec -p vmlinux --args-linux --append="root=/dev/hda1
> > > > maxcpus=1 init 1"
> > >
> > >  kexec-tools-1.101 loads for me, but if cmdline is used, it hangs up
> > > after "Starting new kernel"
> >
> > Thanks for trying this out. As Vivek mentioned can you please try with
> > bulding second or dump capture kernel with CONFIG_SMP=N and _without_
> > maxcpus= option. Basically the second kernel's job is just to save the dump
> > and it doesnot need to be a SMP kernel. There are some issues with booting
> > SMP kernel as dump capture kernel.
> 
> Hm, without 'maxcpus' seems to work. However, when booting into the new 
> kernel, the rootfs had to be fsck'ed due to "/ was not cleanly unmounted, 
> check forced." and then was forced to reboot linux due to inconsistency in 
> the fs. I simply did kexec -l <vmlinux> --args-linux --append="root=/dev/hda1 
> init 1" and then kexec -e to execute the loaded image. It seems that the 
> filesystems are not unmounted properly before loading the second kernel, (or 
> I am missing something..., which is more likely :))
> 
> > Also, it would be great help if you can also send us some hardware details
> > about the system you are trying, like lspci, 
> [root@zmei] lspci -vv

Thanks Boris, I have updated the kdump test page with details you provided. 

http://lse.sourceforge.net/kdump/kdump-test.html

It will be nice if you could try kdump also on the similar lines. 

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
