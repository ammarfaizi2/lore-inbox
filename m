Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbTKMRPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 12:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbTKMRPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 12:15:39 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:29394 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264382AbTKMRPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 12:15:20 -0500
Date: Thu, 13 Nov 2003 06:59:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.6.0-test9-mjb2: emulex driver link error
Message-ID: <5600000.1068735568@[10.10.2.4]>
In-Reply-To: <20031113170108.GN10456@fs.tum.de>
References: <85450000.1068220085@[10.10.2.4]> <20031113170108.GN10456@fs.tum.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> emulex driver					Emulex
>> 	Driver for emulex fiberchannel cards
>> ...
> 
> "copyin" and "copyout" aren't good names for non-static functions:
> 
> <--  snip  -->
> 
> ...
>   LD      drivers/built-in.o
> drivers/scsi/built-in.o(.text+0x1182c0): In function `copyout':
> : multiple definition of `copyout'
> drivers/char/built-in.o(.text+0x58fe0): first defined here
> ld: Warning: size of symbol `copyout' changed from 95 in 
> drivers/char/built-in.o to 55 in drivers/scsi/built-in.o
> drivers/scsi/built-in.o(.text+0x118300): In function `copyin':
> : multiple definition of `copyin'
> drivers/char/built-in.o(.text+0x58f60): first defined here
> ld: Warning: size of symbol `copyin' changed from 125 in 
> drivers/char/built-in.o to 88 in drivers/scsi/built-in.o
> make[1]: *** [drivers/built-in.o] Error 1
> make: *** [drivers] Error 2

Yeah, I think the code in there is pretty ugly ... I think that one
only works as a module right now - sorry.

M.

