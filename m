Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUEZLNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUEZLNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265304AbUEZLNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:13:17 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:38053 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265256AbUEZLNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:13:15 -0400
Message-ID: <40B47BC8.2010209@yahoo.com.au>
Date: Wed, 26 May 2004 21:13:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: mingo@elte.hu, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc1-bk: SMT scheduler bug / crashes on kernel boot
References: <1085568719.2666.53.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1085568719.2666.53.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> Hi,
> 
> Kernel 2.6.7-rc1-bk crashes on boot with a NULL pointer dereference. 
> The kernel is running under VMware if that matters but I don't think it
> should.  It was working fine with 2.6.6-rc3-bk kernels.
> 
> I am afraid the only way I could capture the crash was to capture the
> vmware screen into a PNG image which is attached.  Maybe I need to setup
> some OCR software for in the future...  (-;
> 
> The system running VMware is a P4 2.6Hz with Hyper threading enabled and
> /proc/cpuinfo shows two cpus:

OK, thanks for that. It would be quite helpful if you edit
kernel/sched.c and turn the line #undef SCHED_DOMAIN_DEBUG into
#define SCHED_DOMAIN_DEBUG, then compile a kernel with debugging
info enabled.

Boot again, and capture another screenshot of the oops. This will
hopefully include the SCHED_DOMAIN_DEBUG output.

Also run
	
	addr2line -e /path/to/vmlinux EIP

vmlinux is the file generated in the root directory of the source
tree after compilation. EIP is the EIP value printed by the Oops.

Thanks.
