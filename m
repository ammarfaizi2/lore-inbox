Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWDTJTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWDTJTD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 05:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWDTJTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 05:19:03 -0400
Received: from mail.suse.de ([195.135.220.2]:29395 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750756AbWDTJTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 05:19:02 -0400
Date: Thu, 20 Apr 2006 11:18:56 +0200
From: Nick Piggin <npiggin@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060420091856.GB21660@wotan.suse.de>
References: <20060419112130.GA22648@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419112130.GA22648@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 01:21:30PM +0200, Ingo Molnar wrote:
> the 2.6.17-rc2 kernel built with the attached config crashes quite 
> easily under minimal load. Disabling CONFIG_NUMA makes it robust again.  
> Crashlog attached.

It would be interesting to know which assertion failed. I
guess it might be a zone alignment problem -- it would be
interesting to turn the 2 HOLES_IN_ZONE tests into BUG_ONs,
and enable them (ie. move them out of HOLES_IN_ZONE).

It might be an idea to unconditionally enable DEBUG_VM in
prereleases, too.

Thanks,
Nick
