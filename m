Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVEQKCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVEQKCs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 06:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVEQKCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 06:02:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:2262 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261350AbVEQKCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:02:45 -0400
Date: Tue, 17 May 2005 15:32:27 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: maneesh@in.ibm.com, Vivek Goyal <vgoyal@in.ibm.com>, coywolf@lovecn.org,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: kexec?
Message-ID: <20050517100227.GC6196@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050508202050.GB13789@charite.de> <200505111351.42266.petkov@uni-muenster.de> <20050512064119.GA3870@in.ibm.com> <200505170011.44196.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505170011.44196.petkov@uni-muenster.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 12:11:43AM +0200, Borislav Petkov wrote:
Hi,

> <snip>
> >
> > It will be nice if you could try kdump also on the similar lines.
> 
> HI,
> 
> After patching kexec-tools with the kdump patch here's what I did according to 
> the test plan:
> 
> 0. load kernel with crashkernel=64M@16M
> 1. kexec -p vmlinux --args-linux --append="root=/dev/hda1 init 1" (loads fine)
> 2. sysrq+c
> the system issues here : SysRq: Trigger a crashdump and hangs so that even 
> SysRq is dead.
>

Thanks for testing this out. So kexec on panic seems to be hanging. Are you 
booted in first kernel with commandline option nmi_watchdog? We have a known 
issue with nmi_watchdog and just now I have posted a patch.

Could you please try loading the new kernel with --console-vga or 
--console-serial option (depending on what console you are on) and post 
the output. 

Is it possible to post the .config file for both the kernels as well serial 
console output (if one is setup). This should help.

Thanks
Vivek


 
