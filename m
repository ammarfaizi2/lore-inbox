Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVKRArX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVKRArX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 19:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVKRArX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 19:47:23 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:19673 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751308AbVKRArW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 19:47:22 -0500
Message-ID: <437D248B.9080209@us.ibm.com>
Date: Thu, 17 Nov 2005 16:47:07 -0800
From: Haren Myneni <haren@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>, ak@suse.de,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 8/10] kdump: x86_64 save cpu registers upon crash
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117132138.GG3981@in.ibm.com> <20051117132315.GH3981@in.ibm.com> <20051117132437.GI3981@in.ibm.com> <20051117132557.GJ3981@in.ibm.com> <20051117132659.GK3981@in.ibm.com> <20051117132850.GL3981@in.ibm.com>
In-Reply-To: <20051117132850.GL3981@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:

>o
>
>
>+static void crash_save_self(struct pt_regs *regs)
>+{
>+	int cpu;
>+
>+	cpu = smp_processor_id();
>+	crash_save_this_cpu(regs, cpu);
>+}
>+
> 
> 
>  
>
I think, we can remove crash_save_self() and call crash_save_this_cpu() 
directly from machine_crash_shutdown().

