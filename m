Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268602AbUIMPxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268602AbUIMPxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUIMPt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:49:27 -0400
Received: from [209.88.178.130] ([209.88.178.130]:60405 "EHLO constg.qlusters")
	by vger.kernel.org with ESMTP id S268298AbUIMP2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:28:23 -0400
Message-ID: <4145BC2D.7020209@qlusters.com>
Date: Mon, 13 Sep 2004 18:26:37 +0300
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron
 machines
References: <4145A8E1.8010409@qlusters.com> <4145B606.5080505@didntduck.org>
In-Reply-To: <4145B606.5080505@didntduck.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:

>
> You should never use the unistd.h macros from kernel space.  Call 
> sys_foo() directly.  This may mean you have to export it.  The reason 
> it crashes is that the "syscall" opcode used by the x86-64 macros 
> (unlike the "int $0x80" for i386) causes a fault when already running 
> in kernel space.
>
> -- 
>                 Brian Gerst

I can see from the crash report that the fault happens. I want to 
understand why.

I can use workarounds. (Calling sys_foo() directly from module can be a 
problem -- I would have to know the "versioned"  function name or the 
address of the function within the kernel space.  Calling an entry from 
the syscall table is much easier.)

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------


