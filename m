Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWHKF4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWHKF4G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 01:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWHKF4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 01:56:06 -0400
Received: from ns.suse.de ([195.135.220.2]:19846 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751428AbWHKF4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 01:56:05 -0400
From: Andi Kleen <ak@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH for review] [67/145] x86_64: Detect CFI support in the assembler at runtime
Date: Fri, 11 Aug 2006 07:55:58 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060810935.775038000@suse.de> <20060810193623.1923113B90@wotan.suse.de> <20060811053932.GA4910@mars.ravnborg.org>
In-Reply-To: <20060811053932.GA4910@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608110755.58676.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 August 2006 07:39, Sam Ravnborg wrote:
> > +# as-instr
> > +# Usage: cflags-y += $(call as-instr, instr, option1, option2)
> > +
> > +as-instr = $(shell if echo -e "$(1)" | $(AS) -Z -o /dev/null \
> > +		   2>&1 >/dev/null ; then echo "$(2)"; else echo "$(3)"; fi;)
> 
> Have you checked that as will not delete yout /dev/null if you build as
> root? ld do so if you specify /dev/null as output file.

No. But it's probably safter to do it otherwise. Do you have an alternative?

-Andi
