Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSIHXIx>; Sun, 8 Sep 2002 19:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSIHXIw>; Sun, 8 Sep 2002 19:08:52 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:47279 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S315485AbSIHXIw>; Sun, 8 Sep 2002 19:08:52 -0400
Date: Sun, 8 Sep 2002 16:13:29 -0700
From: "H. J. Lu" <hjl@gnu.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Odd problem with ACPI and i386 kernel
Message-ID: <20020908161329.A21995@lucon.org>
References: <20020908153539.A21352@lucon.org> <Pine.LNX.4.44.0209082346340.2119-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209082346340.2119-100000@localhost.localdomain>; from hugh@veritas.com on Sun, Sep 08, 2002 at 11:55:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2002 at 11:55:58PM +0100, Hugh Dickins wrote:
> On Sun, 8 Sep 2002, H. J. Lu wrote:
> > I have a very strange problem with ACPI and i386 kernel. I built an
> > i386 kernel with ACPI for RedHat installation since my new P4 machines
> > needs ACPI to get IRQ. It works fine on my ASUS P4B533-E MB with Intel
> > 845E chipset. However, on my Sony VAIO GRX560 which is a P4 1.6GHz
> > with Intel 845 chipset, the machine will reboot as soon as the kernel
> > starts to run. I tracked it down to CONFIG_X86_INVLPG. If I enable
> > it, kernel will be fine. Has anyone else seen this?
> 
> Yes, I sent Marcelo the patch below on 27th Aug, it's in 2.4.20-pre5.
> I sent Linus a similar patch (copied to LKML) for the 2.5 tlbflush.h,
> but he didn't care for its "cpu_has_pge" test, nor did he put in its
> #define cpu_has_invlpg	(boot_cpu_data.x86 > 3)
> replacement: I'll resend.
> 
> CONFIG_M386 kernel running on PPro+ processor with X86_FEATURE_PGE may
> set _PAGE_GLOBAL bit: then __flush_tlb_one must use invlpg instruction.
> 

THANKS! It does the trick.


H.J.
