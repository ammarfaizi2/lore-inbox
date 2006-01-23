Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWAVNUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWAVNUo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 08:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWAVNUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 08:20:44 -0500
Received: from savages.net ([66.93.39.90]:32690 "EHLO mail.savages.net")
	by vger.kernel.org with ESMTP id S932427AbWAVNUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 08:20:44 -0500
Message-ID: <43D43EEB.3080209@savages.net>
Date: Sun, 22 Jan 2006 18:26:51 -0800
From: Shaun Savage <savages@savages.net>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1.centos4 (X11/20051007)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: CBD Compressed Block Device, New embedded block device
References: <43D3467C.7010803@tvlinux.org> <20060122082620.GC1543@elf.ucw.cz>
In-Reply-To: <20060122082620.GC1543@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Compression is just one feature.  Each partition is wrapped in a package 
that has a header. even the kernel and boot loader are wrapped in the 
package.  Each package can be hashed and signed.  There is a patch for 
GRUB that boots CBD.  GRUB patch does 3 things, boot the kernel, find 
the latest version of each package, verify hash and signature.  This 
allow for in robust field update of packages.

shaun

Pavel Machek wrote:

>On Ne 22-01-06 00:46:52, Shaun Savage wrote:
>  
>
>>HI
>>
>>Here is a patch for 2.6.14.5 of CBD
>>CBD is a compressed block device that is designed to shrink the file 
>>system size to 1/3 the original size.  CBD is a block device on a file 
>>system so, it also allows for in-field upgrade of file system.  If 
>>necessary is also allows for secure booting, with a GRUB patch.
>>    
>>
>
>What does compression have to do with secure booting?
>
>
>  
>

