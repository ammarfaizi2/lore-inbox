Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317221AbSGCRF0>; Wed, 3 Jul 2002 13:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSGCRFZ>; Wed, 3 Jul 2002 13:05:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:12268 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317221AbSGCRFY>; Wed, 3 Jul 2002 13:05:24 -0400
Date: Wed, 3 Jul 2002 18:07:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit
In-Reply-To: <200207031553.IAA04513@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.21.0207031803250.1391-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002, Adam J. Richter wrote:
> On Wed, 03 Jul 2002 22:27:33 +1000, Keith Owens wrote:
> 
> >It does not.  There is no code to adjust any tables after discarding
> >kernel __init sections.  We rely on the fact that the discarded kernel
> >area is not reused for executable text.
> 
> 	Come to think of it, if the core kernel's .text.init pages could
> later be vmalloc'ed for module .text section, then I think you may have
> found a potential kernel bug.

No: the virtual address (which is what matters) would be different:
core kernel's .text.init is not in vmalloc virtual address range.

Hugh

