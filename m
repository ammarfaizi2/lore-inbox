Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSFTWCQ>; Thu, 20 Jun 2002 18:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSFTWCP>; Thu, 20 Jun 2002 18:02:15 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:57478 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315758AbSFTWCO>; Thu, 20 Jun 2002 18:02:14 -0400
Date: Fri, 21 Jun 2002 00:01:56 +0200
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "laptop mode" for floppies too?
Message-ID: <20020620220156.GA19402@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Marek Michalkiewicz <marekm@amelek.gda.pl>,
	linux-kernel@vger.kernel.org
References: <3D0DB3A7.C32CCAE9@zip.com.au> <E17Jvi0-0007gl-00@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17Jvi0-0007gl-00@alf.amelek.gda.pl>
User-Agent: Mutt/1.4i
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 02:34:12PM +0200, Marek Michalkiewicz wrote:

> And, that would be a global sync() not per-device - looks like a hack
> to me.

You can also fsync() block devices to write out the buffers attached to
it.  Slightly less of a hack that way.

> The floppy driver itself controls the motor, so could also somehow
> tell the kernel to write back all dirty data just before spinning down.
> IDE disks can spin down automatically after some idle time, but perhaps
> it would be more efficient if Linux could do that in software instead -
> tell the disk to go to sleep ("hdparm -y") if it has not been accessed
> for too long, but write all dirty data first (without resetting the idle
> timer - possible now that the timer is ours and not in the disk).

Have a look at noflushd (available via sourceforge).  Never used it with
floppy disks, I admit, but the changes should be straightforward.

Regards,

Daniel.
