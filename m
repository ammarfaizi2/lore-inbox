Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVBBHPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVBBHPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 02:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVBBHPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 02:15:05 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:6605 "HELO
	ns.intellilink.co.jp") by vger.kernel.org with SMTP id S262171AbVBBHO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 02:14:59 -0500
Message-ID: <42009874.7000209@intellilink.co.jp>
Date: Wed, 02 Feb 2005 18:08:04 +0900
From: Koichi Suzuki <koichi@intellilink.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: ebiederm@xmission.com
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based	crashdumps.
References: <overview-11061198973484@ebiederm.dsl.xmission.com>	<1106294155.26219.26.camel@2fwv946.in.ibm.com>	<m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>	<1106305073.26219.46.camel@2fwv946.in.ibm.com>	<m17jm72fy1.fsf@ebiederm.dsl.xmission.com>	<1106475280.26219.125.camel@2fwv946.in.ibm.com>	<m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>	<1106833527.15652.146.camel@2fwv946.in.ibm.com>	<m1zmyueh4c.fsf@ebiederm.dsl.xmission.com>	<41FF381B.4080904@intellilink.co.jp> <m1fz0gbqe5.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fz0gbqe5.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com wrote:
> Koichi Suzuki <koichi@intellilink.co.jp> writes:
> 
> 
>>Hook in panic code is very good idea and is useful in various scenes. It could
>>be used to kick RAM dump code, obviously, and also kick the code to initiate
>>failover, etc.   Various use could be possible so I believe that this hook
>>should be prepared for wider use.
> 
> 
> It is.  Basically it is the normal kexec interface that allows you to
> boot another kernel.  With a few restrictions that should keep it as
> reliable as possible when the kernel has not shut itself down cleanly.
> 
> The hardest case is to do a useful system core dump.  As that requires
> looking at what has gone before.  For the rest if you can do it
> with a kernel and a initramfs you are in good shape.
> 
> There seems to be a significant amount of interest in the full
> system core dump case so that is what the work is concentrating
> on.
> 
> Eric
> 

I meant with kexec and dump hook, there could be many more things can be 
done in addition to full core dump.  Initiating failover to other node 
will be one example.   Starting with this hook, there must be many good 
ideas.   So my idea is to make this hook general purpose, not for 
specific core dump tool.

Koichi Suzuki
