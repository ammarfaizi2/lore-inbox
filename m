Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSKYIxm>; Mon, 25 Nov 2002 03:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSKYIxm>; Mon, 25 Nov 2002 03:53:42 -0500
Received: from ns.tasking.nl ([195.193.207.2]:30469 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S262708AbSKYIxl>;
	Mon, 25 Nov 2002 03:53:41 -0500
Message-ID: <3DE1E665.1060907@netscape.net._>
Date: Mon, 25 Nov 2002 09:59:17 +0100
From: David Zaffiro <DavZaffiro@tasking.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Compiling x86 with and without frame pointer
References: <19005.1037854033@kao2.melbourne.sgi.com> <224900000.1037900678@flay>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I looked at 2.5.47 (with a splattering of performance patches) using 
> gcc 2.95.4 (Debian Woody), on a 16-way NUMA-Q, and did some kernel
> compile testing. The times to do the tests were almost identical
> (within error noise), but the kernel was indeed smaller
> 
>    text    data     bss     dec     hex filename
> 1873293  396231  459388 2728912  29a3d0 2.5.47-mjb1/vmlinux
> 1427355  396875  455356 2279586  22c8a2 2.5.47-mjb1-frameptr/vmlinux
> 

I can't think of any reason why the data- and bss-part of the kernel are 
influenced by a framepointer option, this seems highly illogical. It 
shouldn't make any difference as far as I can tell, maybe you altered 
other options as well? (Could be strange compilerbehaviour though)

Keith's results seem more reliable:

# size 2.4.20-rc2-*/vmlinux
    text    data     bss     dec     hex filename
2669584  337972  402697 3410253  34094d 2.4.20-rc2-fp/vmlinux
2676919  337972  402697 3417588  3425f4 2.4.20-rc2-nofp/vmlinux

