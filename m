Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291422AbSBMGmw>; Wed, 13 Feb 2002 01:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291423AbSBMGmm>; Wed, 13 Feb 2002 01:42:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45067 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291422AbSBMGmh>;
	Wed, 13 Feb 2002 01:42:37 -0500
Date: Wed, 13 Feb 2002 07:42:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
Message-ID: <20020213074214.S1907@suse.de>
In-Reply-To: <20020212175718.P1907@suse.de> <Pine.LNX.4.10.10202122143380.32729-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10202122143380.32729-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12 2002, Andre Hedrick wrote:
> I just love how the copy of a request has worked its way back into to the
> code-base. :-/  I recall Linus stating it was/is a horrid mess.

The copy itself is not the horrid mess, the handling of multi write is
what is the horrible mess. Having a private copy to mess with is pretty
much a necessity IMO if you want to handle > current_nr_sectors at the
time without completing it chunk by chunk.

-- 
Jens Axboe

