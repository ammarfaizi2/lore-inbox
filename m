Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269435AbUIILtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269435AbUIILtR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 07:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269437AbUIILtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 07:49:17 -0400
Received: from ozlabs.org ([203.10.76.45]:29113 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269435AbUIILtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 07:49:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16704.15604.289019.476483@cargo.ozlabs.ibm.com>
Date: Thu, 9 Sep 2004 21:22:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: vDSO for ppc64 : Preliminary release #3
In-Reply-To: <20040909091208.GY31909@devserv.devel.redhat.com>
References: <1094719382.2543.62.camel@gaston>
	<20040909091208.GY31909@devserv.devel.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek writes:

> That is on purpose, even if vDSO location is randomized (e.g. on IA-32),
> no relocations should happen, so that the vDSO can be shared (unless
> written into by the debugger, that is).  ld.so knows how to deal with
> .dynamic section relocation of vDSOs.

On 64-bit architectures which use procedure descriptors, the
descriptors will have to be relocated (unless you or Alan can come up
with some toolchain or ld.so magic or something).  But the descriptors
are in the data section rather than the text, of course.

Paul.
