Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282668AbRK0ATV>; Mon, 26 Nov 2001 19:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282666AbRK0ATM>; Mon, 26 Nov 2001 19:19:12 -0500
Received: from waste.org ([209.173.204.2]:10184 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S282670AbRK0AS6>;
	Mon, 26 Nov 2001 19:18:58 -0500
Date: Mon, 26 Nov 2001 18:21:03 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
cc: Andrew Morton <akpm@zip.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3: kjournald and spun-down disks
In-Reply-To: <20011127002525.A2912@pelks01.extern.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.40.0111261817230.4562-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Daniel Kobras wrote:

> On Fri, Nov 23, 2001 at 05:25:46PM -0800, Andrew Morton wrote:
> > Also, if we had appropriate hooks into the request layer, we could detect
> > when the disk was being spun up for a read, and opporunistically flush
> > out any pending writes.
>
> Actually you can't. SCSI spinup code isn't very useful anyway, and IDE disks
> mostly handle spinup themselves. The kernel has too issue a reset to get a
> disk back alive from sleep mode, but revival from standby doesn't involve
> the kernel at all. When using the disk's internal timer, it isn't involved in
> spindown either. Teaching the request layer about disk state might therefore
> turn out to become rather messy, I suspect.

Depends on how far you want to take it. The kernel can of course query to
discover whether a device is on standby and delay writes if possible
before actually initiating a flush.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

