Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757038AbWKVVgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757038AbWKVVgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757042AbWKVVgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:36:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:48875 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1757038AbWKVVgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:36:53 -0500
Subject: Re: Incorrect order of last two arguments of ptrace for requests
	PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: supriya kannery <supriyak@in.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1164220580.12365.8.camel@hades.cambridge.redhat.com>
References: <453F421A.6070507@in.ibm.com>
	 <1164220580.12365.8.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 08:35:43 +1100
Message-Id: <1164231343.5653.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-22 at 18:36 +0000, David Woodhouse wrote:
> On
> > This is because PPC_PTRACE_GETREGS option for powerpc is implemented 
> > such that general purpose
> > registers of the child process get copied to the address variable 
> > instead of data variable. Same is
> > the case with other PPC request options PPC_PTRACE_SETREGS, GETFPREGS 
> > and SETFPREGS.
> > 
> > Prepared a patch for this problem and tested with 2.6.18-rc6 kernel. 
> > This patch can be applied directly to 2.6.19-rc3 kernel.
> 
> A more appropriate place to send this would be the linux-ppc development
> list.

Also it's possible that existing code like gcc relies on that "feature"
no ?

Ben.
 

