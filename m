Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268975AbUIBUY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268975AbUIBUY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUIBUYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:24:49 -0400
Received: from giesskaennchen.de ([83.151.18.118]:22193 "EHLO
	mail.uni-matrix.com") by vger.kernel.org with ESMTP id S268975AbUIBUXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:23:38 -0400
Message-ID: <4137815F.6040803@giesskaennchen.de>
Date: Thu, 02 Sep 2004 22:23:59 +0200
From: Oliver Antwerpen <olli@giesskaennchen.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Build error (objdump fails)
References: <41377705.9060305@giesskaennchen.de> <20040902201100.GA15298@mars.ravnborg.org>
In-Reply-To: <20040902201100.GA15298@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-giesskaennchen.de-MailScanner-Information: Die Giesskaennchen verschicken keine Viren!
X-giesskaennchen.de-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Thu, Sep 02, 2004 at 09:39:49PM +0200, Oliver Antwerpen wrote:
> 
>>when compiling the linux kernel (I tried 2.6.8, 2.6.8.1, 2.6.9-rc1) I get:
>>arch/i386/kernel/acpi/boot.o: file not recognized: File truncated
> 
> Strange...
> Try the following:
> rm arch/i386/kernel/acpi/boot.o
> make V=1
> 
> Since you have tried several versions I assume this file has been rebuild,
> so it will still fail.

Right. I had tried this before. The gcc-call works just fine, anyway 
boot.o is truncated.

> Try:
> nm -p arch/i386/kernel/acpi/boot.o
> objdump -x arch/i386/kernel/acpi/boot.o

Both say: File truncated

> Try running the gcc command by hand and see if .o file is still bad.

Yes, still bad.


I now tried compiling with gcc-3.4 (3.4.1 (Debian 3.4.1-4sarge1)), that 
works fine.

I am just compiling 2.6.8 with gcc-3.4. This fails at:
mm/fremap.o: file not recognized: File truncated

Any ideas?

Ollfried


