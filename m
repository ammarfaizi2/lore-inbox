Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTJIR3j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 13:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTJIR3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 13:29:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:33957 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262349AbTJIR3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 13:29:38 -0400
Date: Thu, 9 Oct 2003 10:28:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@colin2.muc.de>
cc: Andi Kleen <ak@muc.de>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <bos@serpentine.com>
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
In-Reply-To: <20031009163453.GA977@colin2.muc.de>
Message-ID: <Pine.LNX.4.44.0310091027330.22114-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Oct 2003, Andi Kleen wrote:
> 
> I don't think so. mlockall() should never split anything.

Mut mlock_fixup() _also_ does:
 - set the VM_LOCKED bit
 - do page locked accounting.

So if you don't call it, you may have interesting problems later on.

		Linus

