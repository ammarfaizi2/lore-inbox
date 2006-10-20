Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946424AbWJTPfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946424AbWJTPfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946423AbWJTPfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:35:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:8410 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946420AbWJTPfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:35:43 -0400
Message-ID: <4538ECCD.4020005@us.ibm.com>
Date: Fri, 20 Oct 2006 10:35:41 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com> <4537C807.4@us.ibm.com> <4537CC24.2070708@qumranet.com> <4537CD54.8020006@us.ibm.com> <4537D174.8090204@qumranet.com> <4537D298.6010105@us.ibm.com> <45387DEF.9060903@qumranet.com>
In-Reply-To: <45387DEF.9060903@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Anthony Liguori wrote:
>>>
>>>  writel(dst_x_reg, x);
>>>  writel(dst_y_reg, y)
>>>  writel(width_reg, w);
>>>  writel(height_reg, h);
>>>  writel(blt_cmd_reg, fill);
>>>
>>> then kvm would cache the first four in a mmap()able memory area and 
>>> only exit to userspace on the fifth.  Userspace would then read the 
>>> cached registers from memory and emulate the command.
>>
>> Letting QEMU do a certain amount of emulation after every transition 
>> would the problem in a more elegant and generic way.
>>
>
> But what amount?  A basic block, or several?
>
> Emulation has its costs.  You need to marshal the registers to and 
> fro.  You need to reset qemu's cached translations.  You need to throw 
> away shadow page tables and qemu's softmmu.  You increase the time 
> spent in single threaded code.

Admittedly still a research topic.  If you're interested in what we're 
doing in Xen, check out:

http://xenbits.xensource.com/ext/xen-unstable-hvm.hg (sorry, xenbits is 
down right now but hopefully it will be fixed quickly).

Regards,

Anthony Liguori

