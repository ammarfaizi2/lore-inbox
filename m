Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269372AbUIIJCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269372AbUIIJCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 05:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269373AbUIIJCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 05:02:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:48582 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269372AbUIIJCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 05:02:33 -0400
Subject: Re: vDSO for ppc64 : Preliminary release #3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <1094719382.2543.62.camel@gaston>
References: <1094719382.2543.62.camel@gaston>
Content-Type: text/plain
Message-Id: <1094720488.2667.65.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 19:01:29 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 18:43, Benjamin Herrenschmidt wrote:

> +	/*
> +	 * pick a base address for the vDSO in process space. We have a default
> +	 * base of 1Mb on which we had a random offset up to 1Mb.
> +	 * XXX: Add possibility for a program header to specify that location
> +	 */
> +	current->thread.vdso_base = 0x00100000 
> +		+ 0xaa000;/* + ((unsigned long)vma & 0x000ff000); */
> +

Note that the above is a hack putting the vDSO at 0x1aa000 instead of
it's native link address of 0x100000 to test that it works ;)

Ben.


