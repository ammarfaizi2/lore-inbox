Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264209AbTKMNTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 08:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264222AbTKMNTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 08:19:44 -0500
Received: from mail3-126.ewetel.de ([212.6.122.126]:35548 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S264209AbTKMNTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 08:19:35 -0500
Date: Thu, 13 Nov 2003 14:19:19 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <20031113122039.GJ4441@suse.de>
Message-ID: <Pine.LNX.4.44.0311131418070.947-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Jens Axboe wrote:

>> Are there any cases when the last_written size is really what's wanted,
>> rather than the capacity? Such as unclosed multi-session iso9660, ufs, or
>> whatever else I'm ignoring?
> Yes, for packet written media.
 
My patch from yesterday should handle that situation. 
cdrom_get_last_written is allowed to override the capacity from
cdrom_read_capacity.

-- 
Ciao,
Pascal

