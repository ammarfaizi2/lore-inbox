Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWGDAR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWGDAR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWGDAR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:17:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:20680 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751329AbWGDAR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:17:27 -0400
To: Martin Peschke <mp3@de.ibm.com>
Cc: heiko.carstens@de.ibm.com, clg@fr.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch] statistics infrastructure - update 9
References: <1151943862.2936.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 04 Jul 2006 02:17:25 +0200
In-Reply-To: <1151943862.2936.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Message-ID: <p73ac7qql4a.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke <mp3@de.ibm.com> writes:
>  {
> -#ifdef CONFIG_STATISTICS
>  	unsigned long flags;
>  	local_irq_save(flags);
>  	_statistic_add_as(type, stat, i, value, incr);
>  	local_irq_restore(flags);


Is there a particular reason you can't use local_t with cpu_local_*?
It would be faster on many architectures than local_irq_save/restore

-Andi
