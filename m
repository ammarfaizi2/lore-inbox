Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbUDFWiC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUDFWiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:38:01 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:39585 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S263980AbUDFWhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:37:55 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] don't offer GEN_RTC on ia64
Date: Tue, 6 Apr 2004 16:37:48 -0600
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, p_gortmaker@yahoo.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <200404061622.49260.bjorn.helgaas@hp.com> <20040406223416.GH31152@smtp.west.cox.net>
In-Reply-To: <20040406223416.GH31152@smtp.west.cox.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404061637.48475.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 4:34 pm, Tom Rini wrote:
> On Tue, Apr 06, 2004 at 04:22:49PM -0600, Bjorn Helgaas wrote:
> 
> > gen_rtc.c doesn't work on ia64 (we don't have asm/rtc.h, for starters),
> > so don't offer it there.
> 
> Why not provide asm/rtc.h and kill off drivers/char/efirtc.c instead? :)

Yeah, I was afraid someone would suggest that :-)

I'd actually like to do that, but that's a longer-term project.  And I
don't know the history behind efi_rtc, so maybe there's a good reason
for it being separate.

(Actually, it looks to me like gen_rtc.c ought to be killed off as well,
with both being folded into rtc.c.)
