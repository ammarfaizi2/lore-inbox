Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWHKGmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWHKGmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWHKGmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:42:14 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:28125 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932206AbWHKGmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:42:13 -0400
Date: Fri, 11 Aug 2006 02:37:29 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH for review] [145/145] i386: Disallow kprobes on
  NMI handlers
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608110240_MC3-1-C7C3-777A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060810193745.DBBAA13B8E@wotan.suse.de>

On Thu, 10 Aug 2006 21:37:45 +0200, Andi Kleen wrote:

> --- linux.orig/arch/i386/kernel/entry.S
> +++ linux/arch/i386/kernel/entry.S
> @@ -725,7 +725,7 @@ debug_stack_correct:
>   * check whether we got an NMI on the debug path where the debug
>   * fault happened on the sysenter path.
>   */
> -ENTRY(nmi)
> +KPROBE_ENTRY(nmi)
>       RING0_INT_FRAME
>       pushl %eax
>       CFI_ADJUST_CFA_OFFSET 4

Needs .popsection at the end of the NMI code.

-- 
Chuck
