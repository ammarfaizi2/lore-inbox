Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUIORmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUIORmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUIORlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:41:39 -0400
Received: from mail2.iserv.net ([204.177.184.152]:57758 "EHLO mail2.iserv.net")
	by vger.kernel.org with ESMTP id S267259AbUIORlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:41:05 -0400
Message-ID: <41487EAB.1000004@didntduck.org>
Date: Wed, 15 Sep 2004 13:40:59 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org> <20040915165450.GD6158@wohnheim.fh-wedel.de>
In-Reply-To: <20040915165450.GD6158@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Wed, 15 September 2004 09:30:42 -0700, Linus Torvalds wrote:
> 
>>For example, if you don't know (or, more importantly - don't care) what 
>>kind of IO interface you use, you can now do something like
>>
>>	void __iomem * map = pci_iomap(dev, bar, maxbytes);
>>	...
>>	status = ioread32(map + DRIVER_STATUS_OFFSET);
> 
> 
> C now supports pointer arithmetic with void*?  I hope the width of a
> void is not architecture dependent, that would introduce more subtle
> bugs.
> 
> Jörn
> 

http://gcc.gnu.org/onlinedocs/gcc-3.4.2/gcc/Pointer-Arith.html#Pointer-Arith

5.18 Arithmetic on void- and Function-Pointers

In GNU C, addition and subtraction operations are supported on pointers 
to void and on pointers to functions. This is done by treating the size 
of a void or of a function as 1.

A consequence of this is that sizeof is also allowed on void and on 
function types, and returns 1.

The option -Wpointer-arith requests a warning if these extensions are used.

--
				Brian Gerst
