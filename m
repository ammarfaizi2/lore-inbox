Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbUKPKDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUKPKDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbUKPKCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 05:02:35 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:13289 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261587AbUKPJ44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:56:56 -0500
Date: Tue, 16 Nov 2004 09:56:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Keith Owens <kaos@ocs.com.au>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] WTF is VLI?
In-Reply-To: <13456.1100584810@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0411160948530.4179-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, Keith Owens wrote:
> 
> ksymoops has to work with lots of different log formats from lots of
> different architectures.  Some arch's already print the code around the
> oops and enclose the failing instruction in <> or [], some do not.
> 
> Just looking at a code string, you cannot tell if the arch has variable
> length instructions or not (don't forget that ksymoops also works cross
> architecture).  The VLI tag will work for _all_ architectures that have
> variable length instructions, not just i386.  At the very least, s390
> can use it as well.

But, to an outsider, it seems that the "VLI" can only be relevant when
disassembling the "Code:", and surely each arch disassembler knows
already if it's dealing with Variable Length Instructions.

No big deal, just odd.  I've no wish to add to ksymoops's difficulties.

Hugh

