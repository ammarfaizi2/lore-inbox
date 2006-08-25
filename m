Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWHYMW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWHYMW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 08:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWHYMW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 08:22:56 -0400
Received: from mail.suse.de ([195.135.220.2]:33687 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750789AbWHYMW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 08:22:56 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 10/18] 2.6.17.9 perfmon2 patch for review: PMU context switch support
Date: Fri, 25 Aug 2006 14:20:31 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200608230806.k7N86151000456@frankl.hpl.hp.com> <p73bqqb7nkd.fsf@verdi.suse.de> <20060825115625.GC5330@frankl.hpl.hp.com>
In-Reply-To: <20060825115625.GC5330@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608251420.31564.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 13:56, Stephane Eranian wrote:

> > I suppose some of those functions must be marked __kprobes
> >  
> Are there any guidelines as to why some functions must be ignored
> by kprobes? I assume if meaans they cannot be instrumented.

It does yes.

In general anything that could cause kprobes to recurse is forbidden.
-Andi
