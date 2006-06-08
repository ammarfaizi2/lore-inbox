Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWFHC2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWFHC2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 22:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWFHC2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 22:28:18 -0400
Received: from mail.suse.de ([195.135.220.2]:5579 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932483AbWFHC2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 22:28:17 -0400
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use unlikely() for current_kernel_time() loop
References: <20060607173642.GA6378@schatzie.adilger.int>
From: Andi Kleen <ak@suse.de>
Date: 08 Jun 2006 04:28:12 +0200
In-Reply-To: <20060607173642.GA6378@schatzie.adilger.int>
Message-ID: <p73ejy0tm83.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> writes:

> Hello,
> I just noticed this minor optimization.  current_kernel_time() is called
> from current_fs_time() so it is used fairly often but it doesn't use
> unlikely(read_seqretry(&xtime_lock, seq)) as other users of xtime_lock do.
> Also removes extra whitespace on the empty line above.

It would be better to put the unlikely into the read_seqretry I guess.

-Andi
