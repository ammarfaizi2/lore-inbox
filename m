Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266215AbUGOPit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUGOPit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 11:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUGOPit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 11:38:49 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:46530 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S266215AbUGOPis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 11:38:48 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: bugghy <bugghy@SAFe-mail.net>
Date: Thu, 15 Jul 2004 17:38:30 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: address of int80 idt
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <C32704C118F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jul 04 at 18:27, bugghy wrote:
> 
> The problem is that on some kernels 2.4.22 (and I think on 2.6.7, 2.2.26
> and 2.4.26 too) on vmware sidt returns a bogus address for idtr.base:
> idtr.base=0xffc6a370 (2.4.22) 
> 
> If I try to read from /dev/kmem from this address it doesn't work.

It is feature, not a bug... Well, it is bug, but not easily fixable.
Either check 'Disable acceleration' checkbox in VM configuration, or,
if you want portable solution (if your program has root privileges), call 
iopl(3) before issuing sidt. Or issue sidt in the kernel, not in userspace.
                                                        Best regards,
                                                            Petr Vandrovec
                                                            

