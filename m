Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWHGPdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWHGPdU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWHGPdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:33:19 -0400
Received: from mx1.suse.de ([195.135.220.2]:928 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932153AbWHGPdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:33:19 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Date: Mon, 7 Aug 2006 17:33:13 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071733.13562.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 17:26, Eric W. Biederman wrote:
> 
> Currrently on a SMP system we can theoretically support
> NR_CPUS*224 irqs.  Unfortunately our data structures
> don't cope will with that many irqs, nor does hardware
> typically provide that many irq sources.
> 
> With the number of cores starting to follow Moores
> law, and the apicid limits being raised beyond an 8bit
> number trying to track our current maximum with our
> current data structures would be fatal and wasteful.
> 
> So this patch decouples the number of irqs we support
> from the number of cpus.  We can revisit this decision
> once someone reworks the current data structures.

Ok. I was about to apply it, but it seems to require
mm patches right now, so i didn't

-Andi
