Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVBNGLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVBNGLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 01:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBNGLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 01:11:54 -0500
Received: from www.missl.cs.umd.edu ([128.8.126.38]:44560 "EHLO
	www.missl.cs.umd.edu") by vger.kernel.org with ESMTP
	id S261351AbVBNGLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 01:11:51 -0500
Date: Mon, 14 Feb 2005 01:15:43 -0500 (EST)
From: Adam Sulmicki <adam@cfar.umd.edu>
X-X-Sender: adam@www.missl.cs.umd.edu
To: "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>
cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
In-Reply-To: <Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro>
Message-ID: <Pine.BSF.4.62.0502140113420.21535@www.missl.cs.umd.edu>
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org>
 <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de>
 <Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005, Catalin(ux aka Dino) BOIE wrote:

> I really suggest to push this limit to 4k. My reason is that under UML I need 
> to put a lot of stuff in command line and uml crash if I not extend this 
> limit. Can we make it depend on arhitecture?

another nice feature would be the kernel ignoring the any "/n" in the 
command line. Currently if you accdentally pass the "/n" in the command 
line the most weird things happen.

for examle, type, following

mkelfImage /boot/vmlinuz-2.6.11-rc2-mm1 /boot/vmlinuz-2.6.11-rc2-mm1.elf \
--command-line="console=ttyS0,19200 root=/dev/nfs nfsroot=/ ip=any
init=/usr/src/cm/files/init.kexec.sh"

and watch kernel saying that it does not get any DHCP replies, while the 
real problem is that there's /n before init= line.

