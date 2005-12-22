Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVLVN7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVLVN7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVLVN7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:59:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:57321 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964861AbVLVN7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:59:34 -0500
Date: Thu, 22 Dec 2005 07:59:24 -0600
From: Mark Maule <maule@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 2/4] msi vector targeting abstractions
Message-ID: <20051222135924.GA24232@sgi.com>
References: <20051221184337.5003.85653.32527@attica.americas.sgi.com> <20051221184348.5003.7540.53186@attica.americas.sgi.com> <20051221190558.GD2361@parisc-linux.org> <20051221193300.GK9920@sgi.com> <20051222103606.GA29608@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222103606.GA29608@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 10:36:06AM +0000, Christoph Hellwig wrote:
> > Mainly I did it this way 'cause msg_address seems to be geared toward specific
> > hw (apic?).  In the case of altix interrupt hw, we don't know about
> > dest_mode et. al., but only care about the raw address.
> 
> In that case you should probably kill the struct as I suggested and only
> keep the shift & mask defines in the file for the apic hw implementation.

Yes, that's what I've done (mostly) for the next patch round.  Still haven't
killed the struct, but at least its isolated to apic code now.

Mark
