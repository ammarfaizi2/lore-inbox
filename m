Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVJZUGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVJZUGM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVJZUGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:06:12 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:17547 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S964885AbVJZUGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:06:12 -0400
Message-ID: <435FEFBD.8010702@home.se>
Date: Wed, 26 Oct 2005 23:06:05 +0200
From: Niklas Kallman <kjarvel@home.se>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jack Howarth <howarth@bromo.msbb.uc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI error on x86_64 2.6.13 kernel
References: <fa.gf7dlu0.a4g9qo@ifi.uio.no>
In-Reply-To: <fa.gf7dlu0.a4g9qo@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Howarth wrote:
>    Has anyone reported the following? For both of the 2.6.13 based
> kernels released so far on Fedora Core 4 for x86_64, we are seeing
> error messages of the form...
> 
> Oct  3 11:21:48 XXXXX  kernel:   MEM window: d0200000-d02fffff
> Oct  3 11:21:48 XXXXX  kernel:   PREFETCH window: disabled.
> Oct  3 11:21:48 XXXXX  kernel: PCI: Failed to allocate mem resource #6:20000 f0000000 for 0000:09:00.0
> 
> ..on a Sun W2100Z dual opteron. These memory allocations errors 
> don't occur under the 2.6.12 based kernels that Fedora has released 
> for FC4. So far the errors don't seem to be manifesting themselves 
> as any noticable system errors in using the machine itself.
>                     Jack
> -

I have the same problem on a Dell Inspiron 510m laptop and Fedora Core 4 
when upgrading from 2.6.12 to 2.6.13.* :

I get the following messages at 2.6.13.* startup:

PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Failed to allocate I/O resource #7:1000@10000 for 0000:01:01.0
PCI: Failed to allocate I/O resource #8:1000@10000 for 0000:01:01.0
PCI: Bus 2, cardbus bridge: 0000:01:01.0

I have tried "pci=routeirq", but it makes no difference.
When running 2.6.13.4 I cannot use my WLAN card (ndiswrapper).
With 2.6.12.6 there is no problem at all...

I posted lspci output and more in another mail with subject:
PCI: Failed to allocate I/O resource when upgrading to 2.6.13.*

I'm starting to suspect something in Fedora Core 4 ..

/Niklas
