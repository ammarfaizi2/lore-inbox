Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbSKUWoN>; Thu, 21 Nov 2002 17:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSKUWoN>; Thu, 21 Nov 2002 17:44:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28165 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265037AbSKUWoM>; Thu, 21 Nov 2002 17:44:12 -0500
Date: Thu, 21 Nov 2002 14:50:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] export e820 table on x86
In-Reply-To: <3DDC3E43.2080302@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0211211448460.5779-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Nov 2002, Dave Hansen wrote:
>
> I stole a patch that Arjan did a while ago, and ported it up to 2.5:
> http://www.kernelnewbies.org/kernels/rh80/SOURCES/linux-2.4.0-e820.patch
> 
> We need this so avoid making BIOS calls when using kexec.

Hmm.. So

 - why isn't the info in /proc/iomem good enough - ie wouldn't it be 
   better to just extend resource handling to 64 bit instead of
   creating a new file.

 - please use the seq_file interfaces for new files if you do end up 
   creating new files.

		Linus

