Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422755AbWHXWYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWHXWYX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422768AbWHXWYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:24:23 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:28814 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1422755AbWHXWYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:24:22 -0400
Date: Thu, 24 Aug 2006 23:24:18 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [RFC] maximum latency tracking infrastructure
Message-ID: <20060824222417.GA27504@srcf.ucam.org>
References: <1156441295.3014.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156441295.3014.75.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 07:41:35PM +0200, Arjan van de Ven wrote:

> +	/* the ipw2100 hardware really doesn't want power management delays
> +	 * longer than 500usec
> +	 */
> +	modify_acceptable_latency("ipw2100", 500);
> +

Hm. My BIOS claims that the C3 transition period is 85usec (and even my 
C4 is 185) , but I've hit the error path where C3 gets disabled. Is this 
really adequate? Also, by the looks of it, the C3 disabling path is 
still present - is it still theoretically necessary with the above, or 
is this just a belt and braces approach?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
