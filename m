Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267858AbUHKBB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267858AbUHKBB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 21:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267862AbUHKBB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 21:01:59 -0400
Received: from ozlabs.org ([203.10.76.45]:54993 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267858AbUHKBB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 21:01:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16665.28728.720742.251546@cargo.ozlabs.ibm.com>
Date: Wed, 11 Aug 2004 11:02:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
Subject: Re: AES assembler optimizations
In-Reply-To: <20040810133609.4f1ca352.davem@redhat.com>
References: <2riR3-7U5-3@gated-at.bofh.it>
	<m3d620v11e.fsf@averell.firstfloor.org>
	<1092067328.4332.40.camel@orion>
	<20040809171231.GG2716@mea-ext.zmailer.org>
	<cfb901$ctg$1@terminus.zytor.com>
	<20040810133609.4f1ca352.davem@redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> On sparc64, we:
> 
> 1) Always save the full FPU state at context switch time if it
>    is active.
> 
> 2) On entry to a FPU-using kernel routine, we save the FPU if
>    it is active.

How is that implemented?  Do you have some magic to make gcc emit a
call to an fpu-save routine in the prolog if the function uses the
FPU?  Or are you only talking about functions written in assembler?

Paul.
