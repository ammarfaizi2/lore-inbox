Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWJDU2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWJDU2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWJDU2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:28:39 -0400
Received: from terminus.zytor.com ([192.83.249.54]:14531 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751079AbWJDU2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:28:37 -0400
Message-ID: <45241945.2020105@zytor.com>
Date: Wed, 04 Oct 2006 13:27:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com> <20061003172511.GL3164@in.ibm.com> <20061003201340.afa7bfce.akpm@osdl.org> <20061004042850.GA27149@in.ibm.com> <45233B58.1050208@zytor.com> <20061004202244.GA3629@in.ibm.com>
In-Reply-To: <20061004202244.GA3629@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> 
> Eric/Peter,
> 
> How about just extending bzImage format to include some info in real mode
> kernel header. Say protocol version 2.05. I think if we just include two
> more fields, is kernel relocatable and equivalent of ELF memsz, then probably
> this information should be enough for kexec bzImage loader to load and run
> a relocatable kernel from a different address.
> 

What would be the exact semantics of the "equivalent of ELF memsz"?  I 
have balked on that one in the past, because the proposed semantics were 
unsafe.

I suspect we need at least one more piece of data, which is the required 
alignment of a relocated kernel.  Either which way, it seems clear that 
there is some re-engineering that needs to be done, and I think we need 
to better understand *why* the proposed patch failed.

Can this failure be reproduced in a simulator?

	-hpa

