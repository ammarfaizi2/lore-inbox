Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVEMSEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVEMSEF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVEMSEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:04:05 -0400
Received: from one.firstfloor.org ([213.235.205.2]:4992 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262427AbVEMSEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:04:01 -0400
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
References: <1115963481.1723.3.camel@alderaan.trey.hu>
From: Andi Kleen <ak@muc.de>
Date: Fri, 13 May 2005 20:03:58 +0200
In-Reply-To: <1115963481.1723.3.camel@alderaan.trey.hu> (Gabor MICSKO's
 message of "Fri, 13 May 2005 07:51:20 +0200")
Message-ID: <m164xnatpt.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabor MICSKO <gmicsko@szintezis.hu> writes:

> Hi!
>
> From http://kerneltrap.org/node/5103
>
> ``Hyper-Threading, as currently implemented on Intel Pentium Extreme
> Edition, Pentium 4, Mobile Pentium 4, and Xeon processors, suffers from
> a serious security flaw," Colin explains. "This flaw permits local
> information disclosure, including allowing an unprivileged user to steal
> an RSA private key being used on the same machine. Administrators of
> multi-user systems are strongly advised to take action to disable
> Hyper-Threading immediately."
>
> ``More'' info here:
> http://www.daemonology.net/hyperthreading-considered-harmful/
>
> Is this flaw affects the current stable Linux kernels? Workaround?
> Patch?

This is not a kernel problem, but a user space problem. The fix 
is to change the user space crypto code to need the same number of cache line
accesses on all keys. 

Disabling HT for this would the totally wrong approach, like throwing
out the baby with the bath water.

-Andi
