Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbVK3QX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbVK3QX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVK3QX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:23:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34023 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751443AbVK3QXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:23:25 -0500
Date: Wed, 30 Nov 2005 16:23:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc3-mm1
Message-ID: <20051130162324.GA15273@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20051129203134.13b93f48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129203134.13b93f48.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 08:31:34PM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc3/2.6.15-rc3-mm1/
> 
> - Several ISA sound drivers don't compile.  This is due to a collision
>   between the ALSA and PCMCIA trees, and to breakage in the ALSA tree.
> 
> - drivers/serial/jsm/* still doesn't compile.

Maybe it's time to drop the driver again?  It's known to be very abusive
of tty internals it shouldn't touch and the vendor blocks adding more
hardware support to it because it prefers it own (even worse) driver.

This will give IBM who apparently cares about this hardware the chance to
reintroduce a proper driver again that supports all hardware and doesn't
abuse the tty layer.

