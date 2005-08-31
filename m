Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVHaIHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVHaIHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 04:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVHaIHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 04:07:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35028 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932315AbVHaIHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 04:07:45 -0400
Date: Wed, 31 Aug 2005 10:07:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: A problem about DIRECT IO on ext3
Message-ID: <20050831080744.GM4018@suse.de>
References: <002501c5ac93$6ef754c0$106215ac@realtek.com.tw> <20050829132947.GA21255@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050829132947.GA21255@harddisk-recovery.com>
X-IMAPbase: 1124875140 15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29 2005, Erik Mouw wrote:
> There are four prerequisites for direct IO:
> - the file needs to be opened with O_DIRECT
> - the buffer needs to be page aligned (hint: use getpagesize() instead
>   of assuming that a page is 4k
> - reads and writes need to happen *in* multiples of the soft block size
> - reads and writes need to happen *at* multiples of the soft block size

Actually, the buffer only needs to be hard block size aligned, same goes
for the chunk size used for reads/writes.

-- 
Jens Axboe

