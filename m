Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752042AbWHNT5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbWHNT5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbWHNT5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:57:33 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:58852 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752042AbWHNT5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:57:32 -0400
Date: Mon, 14 Aug 2006 15:57:01 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Don Zickus <dzickus@redhat.com>, fastboot@osdl.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060814195701.GD2519@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060810131323.GB9888@in.ibm.com> <m18xlw34j1.fsf@ebiederm.dsl.xmission.com> <20060810181825.GD14732@in.ibm.com> <m1irl01hex.fsf@ebiederm.dsl.xmission.com> <20060814165150.GA2519@in.ibm.com> <44E0AD1D.1040408@zytor.com> <20060814181118.GB2519@in.ibm.com> <44E0CFD0.3060506@zytor.com> <20060814194252.GC2519@in.ibm.com> <44E0D2DB.7030003@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E0D2DB.7030003@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 12:45:31PM -0700, H. Peter Anvin wrote:
> Vivek Goyal wrote:
> >>>
> >>What about once the kernel is booted?
> >
> >Sorry did not understand the question. Few more lines will help.
> >
> 
> Is this field intended to protect any kind of memory during the early 
> boot phase of the kernel proper, or only the decompressor?
>

I think it should protect against any dynamic memory usage during early
boot phase too till we reach a point where kernel is aware of BIOS provided
memory maps and kernel memory area usage can be controlled with the help
of BIOS provided/User defined memory maps.

In i386 implementation Eric is alredy taking into account the memory
used by bootmem bitmap and initial page tables. I have not looked into
x86_64 kernel code whether do I need to make such adjustments. It worked
for me so did not bother much. I will look into it.

Thanks
Vivek
