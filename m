Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbTGKQXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTGKQXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:23:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45449 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264085AbTGKQW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:22:59 -0400
Date: Fri, 11 Jul 2003 11:37:16 -0500
Subject: Re: Stripped binary insertion with the GNU Linker suggestions (fwd)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
       jcm@printk.net
To: Jon Masters <jonathan@jonmasters.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <Pine.LNX.4.10.10307111655430.25244-100000@router>
Message-Id: <EE71A277-B3BD-11D7-B05B-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, Jul 11, 2003, at 11:00 US/Central, Jon Masters wrote:
>
> The reason I want it is that I am creating a single elf output file 
> which
> is loaded in to SDRAM by a SystemACE chip and in order for that to work
> correctly I need to give the appropriate tools a single elf input
> containing everything where I want it to be loaded in memory.

Not sure I understand the problem exactly, but I believe ppc32 kernels 
do exactly what you want. Have a look at arch/ppc/boot/ld.script and 
see __{image,ramdisk,sysmap}_begin . Also see how e.g. 
arch/ppc/boot/prep/Makefile uses objcopy 
--add-section=.image=vmlinux.gz .

The end result is taking an arbitrary file and stuffing it into an ELF 
section, then using a linker script to provide the start and end 
addresses of the file data.

-- 
Hollis Blanchard
IBM Linux Technology Center

