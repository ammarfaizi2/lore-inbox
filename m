Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288558AbSADJII>; Fri, 4 Jan 2002 04:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288554AbSADJH7>; Fri, 4 Jan 2002 04:07:59 -0500
Received: from mail.s.netic.de ([212.9.160.11]:11795 "EHLO mail.netic.de")
	by vger.kernel.org with ESMTP id <S288555AbSADJHr>;
	Fri, 4 Jan 2002 04:07:47 -0500
To: paulus@samba.org
Cc: Momchil Velikov <velco@fadata.bg>, Tom Rini <trini@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020101234350.GN28513@cpe-24-221-152-185.az.sprintbbd.net>
	<87ital6y5r.fsf@fadata.bg>
	<15411.36909.387949.863222@argo.ozlabs.ibm.com>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 04 Jan 2002 10:05:07 +0100
In-Reply-To: <15411.36909.387949.863222@argo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Thu, 3 Jan 2002 09:56:45 +1100 (EST)")
Message-ID: <87itai32rg.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> One of the reasons why C is a good language for the kernel is that its
> memory model is a good match to the memory organization used by the
> processors that linux runs on.  Thus, for these processors, adding an
> offset to a pointer is in fact simply an arithmetic addition.

But this is not the memory model of C!  Adding an offset to a pointer
is an operation involving objects defined by the C language, and not
machine registers.  Sometimes, this makes a noticeable difference.
