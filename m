Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269300AbUI3PEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269300AbUI3PEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 11:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUI3PEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 11:04:34 -0400
Received: from relay01a.ntr.oleane.net ([194.2.8.85]:28055 "EHLO
	relay01a.ntr.oleane.net") by vger.kernel.org with ESMTP
	id S269300AbUI3PEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 11:04:22 -0400
Message-ID: <415C206F.5090305@eve-team.com>
Date: Thu, 30 Sep 2004 17:04:15 +0200
From: Frederic Dumoulin <frederic_dumoulin@eve-team.com>
Organization: EVE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: building external library under 2.6
References: <415BFB7A.40709@eve-team.com> <31920.194.237.142.24.1096552751.squirrel@194.237.142.24>
In-Reply-To: <31920.194.237.142.24.1096552751.squirrel@194.237.142.24>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't change anything!

Sam Ravnborg wrote:
>>Hi,
>>
>>I succeeded to build an externel module under 2.6 with the following
>>Makefile:
>>
>>ifneq ($(KERNELRELEASE),)
>>obj-m		:= testKernel.o
>>testKernel-objs	:= $(OBJS)
>>else
>>KDIR		:= /lib/modules/$(shell uname -r)/build
>>PWD		:= $(shell pwd)
>>testKernel.ko :
>>	$(MAKE) -C $(KDIR) M=$(PWD) modules
>>endif
> 
> Look ok except the way you use testKernel.ko.
> Much better to use all: since this will not conflict
> with a potential output file.
> 
> 
>>I made modifications in order to build a library:
>>
>>ifneq ($(KERNELRELEASE),)
>>lib-y		:= $(OBJS)
>>else
>>KDIR		:= /lib/modules/$(shell uname -r)/build
>>PWD		:= $(shell pwd)
>>lib.a :
>>	$(MAKE) -C $(KDIR) M=$(PWD) modules
>>endif
> 
> 
> Try wil all: as replacement for lib.a:
> It should cure things.
> 
> No access to Linux box atm so I cannot check.
> 
>    Sam
> 

