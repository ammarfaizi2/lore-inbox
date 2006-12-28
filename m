Return-Path: <linux-kernel-owner+w=401wt.eu-S1754903AbWL1Rbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbWL1Rbg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 12:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754896AbWL1Rbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 12:31:36 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:57894 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754893AbWL1Rbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 12:31:35 -0500
Date: Fri, 29 Dec 2006 02:30:37 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, olpc-devel@laptop.org
Subject: Re: [PATCH] introduce config option to disable DMA zone on i386
Message-ID: <20061228173037.GA22099@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Marcelo Tosatti <marcelo@kvack.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, olpc-devel@laptop.org
References: <20061228170302.GA4335@dmt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228170302.GA4335@dmt>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 03:03:02PM -0200, Marcelo Tosatti wrote:
> The following patch adds a config option to get rid of the DMA zone on i386.
> 
> Architectures with devices that have no addressing limitations (eg. PPC)
> already work this way.
> 
> This is useful for custom kernel builds where the developer is certain that 
> there are no address limitations.
> 
Don't know if you're aware or not, but there's already a CONFIG_ZONE_DMA
in -mm that accomplishes this, which goes a bit further in that it rips
out all of the generic ZONE_DMA references. Quite a few architectures
that have no interest in the zone are using this already.
