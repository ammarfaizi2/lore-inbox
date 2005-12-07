Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVLGPSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVLGPSi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVLGPSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:18:38 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:18949 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751126AbVLGPSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:18:37 -0500
Message-ID: <4396FD4A.5070009@argo.co.il>
Date: Wed, 07 Dec 2005 17:18:34 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hannu Savolainen <hannu@opensound.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random> <200512061426.37287.vda@ilport.com.ua> <Pine.LNX.4.61.0512061707370.23913@zeus.compusonic.fi>
In-Reply-To: <Pine.LNX.4.61.0512061707370.23913@zeus.compusonic.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2005 15:18:35.0886 (UTC) FILETIME=[7E3648E0:01C5FB41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannu Savolainen wrote:

>
>Or why not to include an embedded version of gcc/binutils in the kernel
>LKM interface. In this way all drivers can only be distributed in source 
>code which effectively makes all forms of binary only drivers impossible. 
>After that all the EXPORT_SYMBOL_GPL nonsense can be removed and a proper 
>DDI layer can be implemented for Linux. This makes it possible to ship 
>"outside the kernel build" drivers without a risk of major 
>incompatibility problems in the next kernel version. No, I'm not 100% 
>serious but just 50%.
>
>  
>
char mydriver[] = { 0x90, 0xf3, 0xa4, ... };
struct { unsigned long offset; void* symbol; } fixups[] = { { 79, 
schedule }, ... };

module_init() { link(mydriver, fixups); ((void (*)())mydriver)(); }

:)

-- 
error compiling committee.c: too many arguments to function

