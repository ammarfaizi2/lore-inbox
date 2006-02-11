Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWBKP7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWBKP7T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWBKP7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:59:19 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:38863 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932328AbWBKP7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:59:18 -0500
To: iSteve <isteve@rulez.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Packet writing issue on 2.6.15.1
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com>
	<20060211124818.063074cc@silver>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Feb 2006 16:59:09 +0100
In-Reply-To: <20060211124818.063074cc@silver>
Message-ID: <m3bqxd999u.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iSteve <isteve@rulez.cz> writes:

> On 11 Feb 2006 12:30:03 +0100
> Peter Osterlund <petero2@telia.com> wrote:
> > Unfortunately the driver doesn't support variable packet sizes. You
> > have to format the disc with a fixed packet size.
> > 
> > Incidentally, the latest git tree (2.6.16-rc2-git10) already contains
> > a change which would have made the mount command fail in this case.
> > 
> I apologize for lack of insight in this matter, but... Where is the packet
> fixed/variable size set? In the UDF filesystem? Or somewhere in metadata of the
> CD?

It's CD metadata.

> Can I alter it with some data already on the CD, without losing the data?

Not as far as I know. I think you have to copy the data to the
harddisk, format the disc with cdrwtool and then copy the data back to
the disc.

> If the driver cannot handle variable packet size, and it is not matter of
> filesystem but matter of CDRW (which I presume), shouldn't the whole pktsetup
> fail?

pktsetup can be run before there is a disc in the drive. Therefore,
these kinds of checks are done when you attempt to open the device for
writing.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
