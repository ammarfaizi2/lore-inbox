Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbUBCP2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUBCP2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:28:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40938 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265856AbUBCP2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:28:09 -0500
Date: Tue, 3 Feb 2004 16:28:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Tomas Zvala <tomas@zvala.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040203152805.GI11683@suse.de>
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos> <401FB78A.5010902@zvala.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401FB78A.5010902@zvala.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03 2004, Tomas Zvala wrote:
> Hi,
> I believe he meant to write he umounted it.
> The problem is that there is still some data left in CDRW's cache and it 
> needs to be emptied. That happens when CDRW is ejected and reinserted 
> (that is why windows burning software ie. Nero wants to eject the CDR/RW 
> when it gets written or erased).
> Maybe kernel could flush the buffers/caches or whatever is there when 
> CDROM gets mounted. But im afraid about compatibility with broken drives 
> such as LG.

There's no command to invalidate read cache, you are probably thinking
of the SYNC_CACHE command to flush dirty data to media (which is what LG
fucked up).

IMO, it's a user problem.

-- 
Jens Axboe

