Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbWGaWRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbWGaWRf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 18:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWGaWRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 18:17:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:32935 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751424AbWGaWRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 18:17:33 -0400
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86_64 built-in command line
Date: Tue, 1 Aug 2006 00:17:00 +0200
User-Agent: KMail/1.9.3
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20060731171442.GI6908@waste.org> <200607312207.58999.ak@suse.de> <44CE6AEA.2090909@zytor.com>
In-Reply-To: <44CE6AEA.2090909@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608010017.00826.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 22:41, H. Peter Anvin wrote:
> Andi Kleen wrote:
> >   
> >> +#ifdef CONFIG_CMDLINE_BOOL
> >> +	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> >> +#endif
> > 
> > I think I would prefer a strcat.
> > 
> > Also you should describe the exact behaviour (override/append) in Kconfig help.
> > 
> 
> In the i386 thread, Matt described having a firmware bootloader which 
> passes bogus parameters.  For that case, it would make sense to have a 
> non-default CONFIG option to have override rather than conjoined (and I 
> maintain that the built-in command line should be prepended.)

Is that boot loader common? What's its name? 
If not I would prefer that he keeps the one liner patch to deal
with that private.

For generic semantics strcat (or possible prepend) is probably better.

-Andi
