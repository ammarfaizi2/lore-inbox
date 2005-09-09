Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVIIDsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVIIDsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 23:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVIIDsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 23:48:02 -0400
Received: from ns2.suse.de ([195.135.220.15]:39581 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964961AbVIIDsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 23:48:01 -0400
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kallsyms approach
References: <43206DBB0200007800024447@emea1-mh.id2.novell.com>
From: Andi Kleen <ak@suse.de>
Date: 09 Sep 2005 05:47:59 +0200
In-Reply-To: <43206DBB0200007800024447@emea1-mh.id2.novell.com>
Message-ID: <p733boe52c0.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> writes:


> This patch provides al alternative to the pre-exisiting kallsyms code.
> That code, from a kernel debugger perspective at least, suffers from
> incomplete information, making it impossible to
> (a) disambiguate multiple static functions of the same name (in
> different
> source files),
> (b) determine a complete set of attributes for a symbol (namely, the
> symbol's size, but also its type, which gets converted to an nm-like
> one-
> character representation), and
> (c) retain full section information

I don't think it's a good idea to have two different ways
to do kallsyms. Either we should always use your new
way in standard KALLSYMS or not do it at all.

The major decision factor is how much bloat it adds.
Can you post before/after numbers of binary size? 

If the difference is >5% or so - are there ways to recover
the difference? 

-Andi



