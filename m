Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbSIZRjX>; Thu, 26 Sep 2002 13:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSIZRjX>; Thu, 26 Sep 2002 13:39:23 -0400
Received: from [208.190.191.185] ([208.190.191.185]:509 "HELO
	mail1.newisys.com") by vger.kernel.org with SMTP id <S261423AbSIZRjW> convert rfc822-to-8bit;
	Thu, 26 Sep 2002 13:39:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Question about mapping RAM that's outside the kernel
Date: Thu, 26 Sep 2002 12:44:35 -0500
Message-ID: <D3A72C5007329A4F991C0DD87202259FE3A627@sekhmet.ad.newisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated to kernel 2.4.19 and now ipchains and iptables are broke.
Thread-Index: AcJlgcWLhBzjhO93RLKgQoOnUcJz8QAAaNaA
From: "Josef Zeevi" <josef.zeevi@newisys.com>
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Apologies in advance if this is the wrong forum for this question - pointers to the right one(s) cheerfully accepted.

I am trying to use 2.4.18 64M to let me see up to 16GB of ram (1 gig at a time). 

I boot my system with mem=64M on the cmdline. I can find out exactly (bios holes included) what the memory from 64M and up looks like.

The approach I am thinking of is to map 1G with ioremap and then behind the back of the kernel (i.e. in my driver) change the physical address (keeping the same virtual address from the first ioremap call). However, the calls to ioremap are always smaller than 1G, due to the get_vm_area taking into account the various needs of the kernel.

So, I really would like to work around this. Is there a way to get a 1Gb virtual address space that I can then manage on my own? (Since the physical memory is "unknown" to the kernel I don't think it knows or cares...)

	Thoughts? Suggestions? Ideas?

	Thanks in advance for any help.

	josef
