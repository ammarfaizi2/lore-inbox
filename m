Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUF3XHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUF3XHS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 19:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUF3XHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 19:07:18 -0400
Received: from ozlabs.org ([203.10.76.45]:7555 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263107AbUF3XHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 19:07:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16611.18350.530425.178652@cargo.ozlabs.ibm.com>
Date: Thu, 1 Jul 2004 09:07:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64: lockfix for rtas error log
In-Reply-To: <20040630125027.T21634@forte.austin.ibm.com>
References: <20040629175007.P21634@forte.austin.ibm.com>
	<16610.41869.78636.349800@cargo.ozlabs.ibm.com>
	<20040630125027.T21634@forte.austin.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas,

> Too many kernel trees.  Someone must have whacked the ameslab tree
> by accident, or on purpose, because they got sick of seeing rtas 
> messages.  I don't find the RTAS messages to be pleasent, but simply
> whacking them is not the right solution.  The following diff is 
> between an older tree and the current tree.  If you could re-add 
> these lines, that would be great.

As far as I can see, the ameslab tree has _never_ contained those
lines.  The last change to chrp_setup.c was on 1 May 2004, and neither
that version nor any of the earlier versions that I looked at have
those lines.  Are you sure you don't have that as a local change in
your copy?  Do a bk sfiles -i and a bk push -n and see if it shows up.

In any case the #ifdef is redundant, because chrp_setup.o is only
linked in if CONFIG_PPC_PSERIES is set.

As for the RTAS messages being printk'd, the only possible
justification would be if there was a userspace tool to analyse them.
I don't know if such a thing exists, and if it does, I certainly don't
have a copy.  Is anyone working on that?

Paul.
