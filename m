Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318235AbSGWVQy>; Tue, 23 Jul 2002 17:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSGWVQy>; Tue, 23 Jul 2002 17:16:54 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:38644 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318235AbSGWVQx>; Tue, 23 Jul 2002 17:16:53 -0400
Subject: Re: [PATCH] VM accounting 1/3 trivial
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Robert Love <rml@tech9.net>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0207231823470.10982-100000@localhost.localdomain>
References: <Pine.LNX.4.21.0207231823470.10982-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Jul 2002 23:33:04 +0100
Message-Id: <1027463584.31782.148.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 18:27, Hugh Dickins wrote:
> First of three patches against 2.4.19-rc3-ac3 fixing some VM accounting.
> Could be split further, but this one too trivial to need much thought.
> 
> 1. do_munmap doesn't need an extra acct arg (and rc3-ac3 still leaves
>    arch files without it): just clear VM_ACCOUNT in mremap's move_vma.

Are you sure that is correct. I started off on that basis but never got
it to work reliably when mremap changes multiple vmas ?

Can you split out items #2, #4 first of all and submit those alone, then
I can review each item on its own and run vm_validate tests

