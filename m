Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUA0Tqc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUA0Tqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:46:31 -0500
Received: from gw2.cosmosbay.com ([195.115.130.129]:17568 "EHLO
	gw2.cosmosbay.com") by vger.kernel.org with ESMTP id S265768AbUA0Tp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:45:27 -0500
Message-ID: <4016BFD4.2040407@cosmosbay.com>
Date: Tue, 27 Jan 2004 20:45:24 +0100
From: dada1 <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.1 x86_64 : STACK_TOP and text/data
References: <OFCE30A640.024A04A1-ONC1256E28.003023EA-C1256E28.0030BF4E@de.ibm.com.suse.lists.linux.kernel>	<40162E9A.1080005@cosmosbay.com.suse.lists.linux.kernel>	<p73k73dfdvs.fsf@nielsen.suse.de>	<4016B493.9050404@cosmosbay.com> <20040127202930.6c29bbcf.ak@suse.de>
In-Reply-To: <20040127202930.6c29bbcf.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>
>You're right. Thanks for reporting this. This seems to be a 2.6 
>specific bug, it didn't happen in 2.4.
>
>I will fix it. It should definitely use PAGE_OFFSET for 64bit 
>processes and 4GB for !3GB 32bit processes.
>
>-Andi
>
>
>  
>
Another thing I noticed in last glibc CVS (nptl)

Thread stacks are also allocated in the 1GB quadrant :

nptl/sysdeps/x86_64/pthreaddef.h
/* We prefer to have the stack allocated in the low 4GB since this
   allows faster context switches.  */      
#define ARCH_MAP_FLAGS MAP_32BIT 

Is this really true ?
Is memory allocated in the low 4GB is faster on x86_64  (64bit kernel, 
64 bit user prog ?)

Thank you

Eric Dumazet


