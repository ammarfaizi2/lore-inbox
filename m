Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbVL2UAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbVL2UAg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbVL2UAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:00:36 -0500
Received: from waste.org ([64.81.244.121]:29106 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750936AbVL2UAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:00:35 -0500
Date: Thu, 29 Dec 2005 13:56:41 -0600
From: Matt Mackall <mpm@selenic.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-tiny@selenic.com
Subject: Re: Fwd: [PATCH] Make sysenter support optional
Message-ID: <20051229195641.GB3356@waste.org>
References: <20051228212402.GX3356@waste.org> <a36005b50512281407x74415958tb0fa2b52f4dd7988@mail.gmail.com> <43B30E19.6080207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B30E19.6080207@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 02:13:45PM -0800, Ulrich Drepper wrote:
> > This adds configurable sysenter support on x86. This saves about 5k on
> > small systems.
> 
> You not only remove the sysenter support but also the vdso.  And the
> later is a very bad idea.  It is already today basically impossible to
> have reliable backtraces without the vdso and the unwind info it
> contains for signal handlers.  And things can only get worse in future.
>  The magic heuristics in the compiler are not reliable.  It's simply the
> wrong face, this in a interface between the kernel and the libc, the
> compiler should not have such knowledge.
> 
> The vdso should be mandatory for all configurations.

It's under CONFIG_EMBEDDED. Think uclibc. Think systems without
interactive shells.

-- 
Mathematics is the supreme nostalgia of our time.
