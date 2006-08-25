Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422817AbWHYBaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422817AbWHYBaY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 21:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422818AbWHYBaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 21:30:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:23524 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422817AbWHYBaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 21:30:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ldts4HyW95jECM2ND56tbX8p2TE0icb5TFN5dM7gjqJgLBF+QmYn/PFUF8u/s4+hYK3l+Qk00uF+u8xGjTaTam6RZqQOP/68lE/0ZTJCCrUzF7vRtAioIHl/Nw23Qua/dnh7+pdNUTxPpMM+iGKb620XuYcSA3Wu9PCmRnVClpI=
Message-ID: <a2ebde260608241830p2d26b20bp6bfb9b1b5a267ec6@mail.gmail.com>
Date: Fri, 25 Aug 2006 09:30:21 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>, ak@suse.de
Subject: Re: Unnecessary Relocation Hiding?
Cc: "Christoph Lameter" <clameter@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <17646.14056.102017.127644@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com>
	 <Pine.LNX.4.64.0608241125140.4394@schroedinger.engr.sgi.com>
	 <17646.14056.102017.127644@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for perhaps extending the specific question to a more generic
one. In which cases shall we, in current or future development,
prevent gcc from knowing a pointer-addition in the way RELOC_HIDE? And
in what cases shall we just write pure C point addition?

After all, we are writing an OS in C not in pure assembly, so I am
just trying to learn some generial rules to mimize the raw assembly in
development.

Feng,Dong


2006/8/25, Paul Mackerras <paulus@samba.org>:
> Christoph Lameter writes:
>
> No, RELOC_HIDE came from ppc originally.  The reason for it is that
> gcc assumes that if you add something on to the address of a symbol,
> the resulting address is still inside the bounds of the symbol, and do
> optimizations based on that.  The RELOC_HIDE macro is designed to
> prevent gcc knowing that the resulting pointer is obtained by adding
> an offset to the address of a symbol.  As far as gcc knows, the
> resulting pointer could point to anything.
>
> It has nothing to do with linker relocations.
>
> Paul.
