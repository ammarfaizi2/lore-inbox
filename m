Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVLVKgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVLVKgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 05:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVLVKgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 05:36:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2275 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750850AbVLVKgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 05:36:10 -0500
Date: Thu, 22 Dec 2005 10:36:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mark Maule <maule@sgi.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 2/4] msi vector targeting abstractions
Message-ID: <20051222103606.GA29608@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Maule <maule@sgi.com>, Matthew Wilcox <matthew@wil.cx>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com> <20051221184348.5003.7540.53186@attica.americas.sgi.com> <20051221190558.GD2361@parisc-linux.org> <20051221193300.GK9920@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221193300.GK9920@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mainly I did it this way 'cause msg_address seems to be geared toward specific
> hw (apic?).  In the case of altix interrupt hw, we don't know about
> dest_mode et. al., but only care about the raw address.

In that case you should probably kill the struct as I suggested and only
keep the shift & mask defines in the file for the apic hw implementation.

