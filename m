Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWC0H3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWC0H3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 02:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWC0H3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 02:29:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15924 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750769AbWC0H3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 02:29:37 -0500
Date: Mon, 27 Mar 2006 09:29:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Dan Aloni <da-x@monatomic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of NCQ in libata
Message-ID: <20060327072945.GC8186@suse.de>
References: <20060326192749.GA3643@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326192749.GA3643@localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26 2006, Dan Aloni wrote:
> Hello,
> 
> I'd like to know about the current status of NCQ support in libata,
> whether anyone is actively working on it, where I should find a 
> development branch (there's no ncq branch anymore in libata-dev.git
> it seems) and when an upstream merge should be expected.

You can give it a spin in the 'ncq' branch in the block layer git repo:

git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git

Only one real bit needs to get merged in libata for ncq to be submitted,
and that is Tejun's eh rework. Once that is in, ncq becomes a fairly
small patch and can probably go straight in.

AHCI is still the only supported controller, once NCQ is merged I'm sure
a few others will follow.

-- 
Jens Axboe

