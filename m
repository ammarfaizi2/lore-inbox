Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSHOTbH>; Thu, 15 Aug 2002 15:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317352AbSHOTbH>; Thu, 15 Aug 2002 15:31:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42509 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317351AbSHOTbH>; Thu, 15 Aug 2002 15:31:07 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: mmap'ing a large file
Date: 15 Aug 2002 12:34:32 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ajgvo8$qh6$1@cesium.transmeta.com>
References: <050a01c243a9$2afa3590$f6de11cc@black> <1029342745.8255.6.camel@lemsip>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1029342745.8255.6.camel@lemsip>
By author:    Gianni Tedesco <gianni@ecsc.co.uk>
In newsgroup: linux.dev.kernel
> 
> Intel is a 32bit architecture, that is to say the address space is 2^32
> bytes (4GB), of this address space the kernel takes the top 2GB and
> userspace the bottom 2GB.
> 

NAK.  3 GB userspace, 1 GB kernel space is the default.

The 3 GB is subdivided into 1 GB for the program, and 2 GB for libraries
and other mmaps (grows up) and the stack (grows down).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
