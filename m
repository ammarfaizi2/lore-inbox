Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264315AbUEDL4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbUEDL4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 07:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264316AbUEDL4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 07:56:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14730 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264315AbUEDLz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 07:55:58 -0400
Date: Tue, 4 May 2004 13:55:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: freezes with cdrecord
Message-ID: <20040504115555.GC1909@suse.de>
References: <200405041145.05894.Alexander.Zviagine@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405041145.05894.Alexander.Zviagine@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04 2004, Alexander ZVYAGIN wrote:
> Hello,
> 
> I use DVD+RW with 2.6.5 kernel. Very often my computer
> freezes for ~10-20 seconds when a disk is cleaning.
> I can move my mouse pointer, and switch between some
> windows, but that is all. Command prompt is
> not responding as well. For me it looks like the
> filesystem is locked.
> 
> During the burning process everything is fine and
> smooth. But very close to the end, the computer freezes
> again for ~10-20 seconds. It happens in 'fixating' stage
> of the writing process.
> 
> The created disks are fine, and computer runs OK.
> I use k3b fronted to cdrecord 2.1a25.
> 
> Any explanations why those freezes happen?

It's because you have other devices on the channel where your recorder
is, and they are frozen when the finalize runs. So move devices around,
or live with it... There's nothing the kernel can do to help you.

-- 
Jens Axboe

