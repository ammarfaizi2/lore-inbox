Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWDXTJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWDXTJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWDXTJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:09:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58658 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751132AbWDXTJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:09:55 -0400
Date: Mon, 24 Apr 2006 21:10:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] iosched: use hlist for request hashtable
Message-ID: <20060424191026.GI29724@suse.de>
References: <20060424083804.GB6227@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424083804.GB6227@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24 2006, Akinobu Mita wrote:
> Use hlist instead of list_head for request hashtable in deadline-iosched
> and as-iosched. It also can remove the flag to know hashed or unhashed.
> 
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
> CC: Jens Axboe <axboe@suse.de>

Looks good, I did the same conversion in cfq ages ago. It saves memory
in the drq/arq structures, which is definitely a good thing. I've
applied it, thanks!

-- 
Jens Axboe

