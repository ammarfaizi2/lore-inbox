Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131846AbRAKGGF>; Thu, 11 Jan 2001 01:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130436AbRAKGFy>; Thu, 11 Jan 2001 01:05:54 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:23563 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S131846AbRAKGFq>; Thu, 11 Jan 2001 01:05:46 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Antony Suter <antony@mira.net>
cc: List Linux-Kernel <linux-kernel@vger.kernel.org>,
        Allen Unueco <allen@premierweb.com>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Thu, 11 Jan 2001 16:38:50 +1100."
             <3A5D46EA.280692B2@mira.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Jan 2001 17:05:23 +1100
Message-ID: <11540.979193123@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001 16:38:50 +1100, 
Antony Suter <antony@mira.net> wrote:
>Allen Unueco wrote:
>> I ran into this while hacking the Nvidia kernel driver to work with
>> 2.4.0.  I got the driver working but it's not 100%
>> 
>> Also where did get_module_symbol() and put_module_symbol() go?
>
>Patches for the NVIDIA binary X drivers following all these kernel
>changes can be gotten from IRC server irc.openprojects.net, channel
>#nvidia. Or from http://ex.shafted.com.au/nvidia/

And what a pile of crud those patches are!!  Instead of using the clean
replacement interface for get_module_symbol, nvidia/patch-2.4.0-PR hard
codes the old get_module_symbol algorithm as inline code.

This patch violates the modules interface by accessing modules.c
internal data.  It still suffers from all the problems that
get_module_symbol had.  Because it is hard coded as inline code instead
of a common function, will be much harder to fix when it breaks.

Whoever coded that patch should be taken out and shot, hung, drawn and
quartered then forced to write COBOL for the rest of their natural
life.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
