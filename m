Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbTIDAeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTIDAeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:34:09 -0400
Received: from ozlabs.org ([203.10.76.45]:33939 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264297AbTIDAeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:34:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16214.34933.827653.37614@nanango.paulus.ozlabs.org>
Date: Thu, 4 Sep 2003 10:33:57 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <20030903203231.GA8772@lst.de>
References: <20030903203231.GA8772@lst.de>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> The 44x merge fucked this up, bring it back in linux with the other
> architectures.

I don't see why this is a problem.  The change is compatible with the
existing uses.  We need to be able to map 36-bit physical addresses on
44x.  What we really need now is 64-bit start/end values in struct
resource.

> /me still boggles how a patch like that could have sneaked in without
> a review on lkml..

First, it's a PPC-only change, and secondly, it's been around for
months in the linuxppc-2.5 tree - since June last year in fact, and
even longer than that in the linuxppc_2_4_devel tree.  Lkml is not
where most PPC-specific stuff gets discussed, it's too noisy for that.

Paul.

