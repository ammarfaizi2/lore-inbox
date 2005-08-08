Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVHHT2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVHHT2y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 15:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVHHT2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 15:28:54 -0400
Received: from ns1.suse.de ([195.135.220.2]:8111 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932209AbVHHT2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 15:28:53 -0400
Date: Mon, 8 Aug 2005 21:28:50 +0200
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de, kaos@sgi.com
Subject: Re: [patch 1/1] x86_64: Rename KDB_VECTOR to DEBUGGER_VECTOR
Message-ID: <20050808192850.GQ19170@wotan.suse.de>
References: <resend.1.882005.trini@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <resend.1.882005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 12:27:10PM -0700, Tom Rini wrote:
>  {
>  	unsigned int icr =  APIC_DM_FIXED | shortcut | vector | dest;
> -	if (vector == KDB_VECTOR)
> +	if (vector == NMI_VECTOR)
>  		icr = (icr & (~APIC_VECTOR_MASK)) | APIC_DM_NMI;

That if () should be removed since it's useless.
Can you do that please?

-Andi
