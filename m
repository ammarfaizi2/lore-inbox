Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVG1MGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVG1MGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 08:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVG1MGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 08:06:33 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:55713 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261415AbVG1MGa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 08:06:30 -0400
In-Reply-To: <e93921519c29efda5b7a304d019dcc94@helenandmark.org>
References: <e93921519c29efda5b7a304d019dcc94@helenandmark.org>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b7628665a1ab5a48aa9bed28256a6dfc@helenandmark.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Mark Burton <mark@helenandmark.org>
Subject: Re: tx queue start entry x dirty entry y (was 8139too PCI IRQ issues)
Date: Thu, 28 Jul 2005 14:06:08 +0200
To: Mark Burton <mark@helenandmark.org>
X-Mailer: Apple Mail (2.622)
X-Spam-Virus: No
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For reference,
Thanks to Ogawa Hirofumi,
the solution was to use noapic on the boot line, as my machine is too 
old to handle APIC well.

Cheers

Mark.

On 19 Jul 2005, at 18:00, Mark Burton wrote:

> Hi,
> I'm getting similar results to Nick Warne, in that when my ethernet is 
> stressed at all (for instance by NFS), I end up with
> nfs: server..... not responding, still trying
> nfs: server .... OK
>
> With a realtec card, I get errors in /var/spool/messages along the 
> lines of:
> Jul  3 14:31:13 localhost kernel: eth1: Transmit timeout, status 0c 
> 0005 c07f media 00.
> Jul  3 14:31:13 localhost kernel: eth1: Tx queue start entry 1160  
> dirty entry 1156.
> Jul  3 14:31:13 localhost kernel: eth1:  Tx descriptor 0 is 0008a03c. 
> (queue head)
>
> I have no TPM (as far as I can find)
>
> Hence I dont think this is the same problem, but it's manifestation is 
> identical.
>
> I was using a realtec card, using the 8139too driver, hence I first 
> suspected that. As a test, I have an even older 3com509B, using that 
> gives exactly the same results (though it doens't seem to be kind 
> enough to output anything to /var/log/debug, so all you get are the 
> "server not responding" messages under heavy NFS load.
> lsmod however, shows both modules loaded....
>
> I'm running debian, and recently got a recent kernel image
> /proc/version gives:
> Linux version 2.6.11-1-386 (dannf@firetheft) (gcc version 3.3.6 
> (Debian 1:3.3.6-6)) #1 Mon Jun 20 20:53:17 MDT 2005
>
> Im not a kernel expert at all, any help sorting this problem would be 
> appreciated, but Its only worth fixing if it's a general problem -- 
> if' I'm on my own, I'll fix it with a band-aid :-)
>
> Cheers
>
> Mark.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

