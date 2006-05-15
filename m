Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWEOPuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWEOPuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWEOPuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:50:35 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:55164 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751517AbWEOPue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:50:34 -0400
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="276824547:sNHT7776899824"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21 of 53] ipath - use phys_to_virt instead of bus_to_virt
X-Message-Flag: Warning: May contain useful information
References: <4e0a07d20868c6c4f038.1147477386@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 08:50:27 -0700
In-Reply-To: <4e0a07d20868c6c4f038.1147477386@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 12 May 2006 16:43:06 -0700")
Message-ID: <adad5efuw1o.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 15:50:28.0793 (UTC) FILETIME=[4A12FA90:01C67837]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I think Roland already has this patch.

 >  	 * This is a bit of a hack since we rely on dma_map_single()
 > -	 * being reversible by calling bus_to_virt().
 > +	 * being reversible by calling phys_to_virt().

Actually I NAK'ed this patch.  It compiles the same thing on x86_64
but makes the source code wrong -- dma_map_single() returns a bus
address, not a physical address.

 - R.
