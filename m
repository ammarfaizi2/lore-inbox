Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWHTSdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWHTSdH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWHTSdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:33:07 -0400
Received: from relay02.pair.com ([209.68.5.16]:24845 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751128AbWHTSdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:33:05 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Date: Sun, 20 Aug 2006 13:32:39 -0500
User-Agent: KMail/1.9.4
Cc: Arnd Bergmann <arnd@arndb.de>,
       =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <200608201237.13194.chase.venters@clientec.com> <20060820112523.f14fc6dc.akpm@osdl.org>
In-Reply-To: <20060820112523.f14fc6dc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608201333.02951.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 13:25, Andrew Morton wrote:
> On Sun, 20 Aug 2006 12:36:49 -0500
>
> Chase Venters <chase.venters@clientec.com> wrote:
> > Unless 'errno' has some significant reason to live on in the kernel, I
> > think it would be better to kill it and write kernel syscall macros that
> > don't muck with it.
>
> We have been working in that direction.  It's certainly something we'd like
> to kill off.

Perhaps Arnd's patch is a good step in that direction then. A secondary 
suggestion is to put a big comment there that explains "Yes, we know this is 
ugly, it's going to die soon."

I'd also consider going so far as just returning -1 if we failed, since we 
can't quite trust errno anyway.

Thanks,
Chase
