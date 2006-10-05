Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWJEERt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWJEERt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWJEERt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:17:49 -0400
Received: from terminus.zytor.com ([192.83.249.54]:44736 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750761AbWJEERt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:17:49 -0400
Message-ID: <45248751.4060607@zytor.com>
Date: Wed, 04 Oct 2006 21:17:21 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>	<20061003172511.GL3164@in.ibm.com>	<20061003201340.afa7bfce.akpm@osdl.org>	<20061004042850.GA27149@in.ibm.com> <45233B58.1050208@zytor.com>	<m1sli4cxr2.fsf@ebiederm.dsl.xmission.com>	<4523D0AF.5000907@zytor.com> <m1u02jbdus.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1u02jbdus.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> Well, it doesn't help if what you end up with for some bootloader is a
>> nonfunctioning kernel.
> 
> I agree.  We need to look at what is happening closely.  
> However just because we have some initial glitches doesn't mean we
> shouldn't give up.
> 
> With grub you can say:
> kernel --type=biglinux /path/to/bzImage
> 
> As I read the code it won't necessarily force the type of kernel image
> grub will use but it will refuse to boot if it doesn't recognize 
> the kernel as the type specified.
> 
> The code for grub is in stage2/boot.c:load_image().  It tries a few
> other formats before it tests for the linux magic number but
> it won't recognize an ELF format executable unless it is a mutliboot
> or a BSD executable.
> 

This isn't just about Grub, though.  There is probably about a dozen 
bootloaders in use on i386, if not more.

	-hpa
