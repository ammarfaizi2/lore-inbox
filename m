Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWHGFka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWHGFka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWHGFka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:40:30 -0400
Received: from ns.suse.de ([195.135.220.2]:40105 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751083AbWHGFk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:40:29 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 4/4] x86 paravirt_ops: binary patching infrastructure
Date: Mon, 7 Aug 2006 07:38:13 +0200
User-Agent: KMail/1.9.3
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1154925835.21647.29.camel@localhost.localdomain> <1154926048.21647.35.camel@localhost.localdomain> <1154926114.21647.38.camel@localhost.localdomain>
In-Reply-To: <1154926114.21647.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608070738.13768.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 06:48, Rusty Russell wrote:

>  
> +#ifdef CONFIG_PARAVIRT
> +void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)

It would be better to merge this with the existing LOCK prefix patching
or perhaps the normal alternative() patcher (is there any particular
reason you can't use it?)

Three alternative patching mechanisms just seems to be too many

-Andi
