Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVH3HGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVH3HGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 03:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVH3HGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 03:06:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45576 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751126AbVH3HGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 03:06:34 -0400
Date: Tue, 30 Aug 2005 08:06:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Dan Malek <dan@embeddededge.com>,
       Pantelis Antoniou <panto@intracom.gr>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
Message-ID: <20050830080626.A19060@flint.arm.linux.org.uk>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	linux-kernel@vger.kernel.org, Dan Malek <dan@embeddededge.com>,
	Pantelis Antoniou <panto@intracom.gr>
References: <20050830024840.GA5381@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050830024840.GA5381@dmt.cnet>; from marcelo.tosatti@cyclades.com on Mon, Aug 29, 2005 at 11:48:40PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 11:48:40PM -0300, Marcelo Tosatti wrote:
> Here goes the 8xx PCMCIA driver, originally written by Magnus Damm, with
> several improvements and fixes.

Please don't copy me on PCMCIA stuff - I don't look after PCMCIA anymore.
Please use the linux-pcmcia mailing list on lists.infradead.org.  Thanks.

> Russell: The driver is using pccard_nonstatic_ops for card window
> management, even though the driver its marked SS_STATIC_MAP (using
> mem->static_map).
> 
> Otherwise card IO windows aren't allocated properly.

This seems very wrong.  Are you suggesting that IO windows need to be
dynamic and memory windows static?  If so, the pcmcia code isn't
designed to cope with that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
