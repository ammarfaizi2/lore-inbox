Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264765AbSJOT2D>; Tue, 15 Oct 2002 15:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264766AbSJOT2D>; Tue, 15 Oct 2002 15:28:03 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:8357 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S264765AbSJOT2C>; Tue, 15 Oct 2002 15:28:02 -0400
Date: Tue, 15 Oct 2002 12:33:49 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [PATCH] superbh, fractured blocks, and grouped io
Message-ID: <20021015193348.GN22117@nic1-pc.us.oracle.com>
References: <20021014135100.GD28283@suse.de> <20021014181338.GF22117@nic1-pc.us.oracle.com> <20021015074423.GE5294@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015074423.GE5294@suse.de>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 09:44:23AM +0200, Jens Axboe wrote:
> We don't want to make them too large anyway, and I think that 64k-1 is
> more than enough. Maybe it would even be better to simply use an even
> 32kb. Consider someone writing in chunks of 64kb. It would simply suck
> to get one 65024b request followed by a 512b one.

	Well, 64K-1 is really 64K-hardsect_size.  In practice, it will
probably be 32K, as folks like power-of-two buffers.  Some people would
claim that larger sizes (128K, 512K) can improve throughput.

Joel

-- 

Life's Little Instruction Book #356

	"Be there when people need you."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
