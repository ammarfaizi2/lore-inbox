Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267779AbUIGJ7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267779AbUIGJ7o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 05:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUIGJ7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 05:59:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53892 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267779AbUIGJ7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 05:59:42 -0400
Date: Tue, 7 Sep 2004 11:58:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remember to check return value from __copy_to_user() in cdrom_read_cdda_old()
Message-ID: <20040907095833.GM6323@suse.de>
References: <Pine.LNX.4.61.0409062335250.2705@dragon.hygekrogen.localhost> <20040907080223.GF6323@suse.de> <16701.32784.10441.884090@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16701.32784.10441.884090@cargo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07 2004, Paul Mackerras wrote:
> Jens Axboe writes:
> 
> > __copy_to_user is the unchecking version of copy_to_user.
> 
> It doesn't range-check the address, but it does return non-zero
> (number of bytes not copied) if it encounters a fault writing to the
> user buffer.

I don't see your point. We already access checked the range, so if
__copy_to_user() returns non-zero, the application is buggy.

-- 
Jens Axboe

