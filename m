Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282508AbRLWRpH>; Sun, 23 Dec 2001 12:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282547AbRLWRo5>; Sun, 23 Dec 2001 12:44:57 -0500
Received: from mailf.telia.com ([194.22.194.25]:62696 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S282508AbRLWRor>;
	Sun, 23 Dec 2001 12:44:47 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: "sr: unaligned transfer" in 2.5.2-pre1
From: Peter Osterlund <petero2@telia.com>
Date: 23 Dec 2001 18:44:43 +0100
Message-ID: <m2vgexzv90.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When trying to mount an ISO9660 CD on my USB CDRW unit, I get lots
of "sr: unaligned transfer" messages from the kernel and the mount
command fails. This message was added in kernel 2.5.1 and the
sr_scatter_pad() function was removed at the same time. The comment
above the message hints that unaligned transfers are (or were) a
normal thing.

I added a printk to get more information:

        sr: unaligned transfer
        sr: sector 64, s_size 2048, bufflen 1024
        sr: unaligned transfer
        sr: sector 68, s_size 2048, bufflen 1024
        sr: unaligned transfer
        sr: sector 72, s_size 2048, bufflen 1024
        ...
        sr: unaligned transfer
        sr: sector 396, s_size 2048, bufflen 1024
        Unable to identify CD-ROM format.

So, what changes are needed to make CD support work?

-- 
Peter Österlund             petero2@telia.com
Sköndalsvägen 35            http://w1.894.telia.com/~u89404340
S-128 66 Sköndal            +46 8 942647
Sweden
