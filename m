Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132582AbRDKOYj>; Wed, 11 Apr 2001 10:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132579AbRDKOYa>; Wed, 11 Apr 2001 10:24:30 -0400
Received: from mta02-acc.tin.it ([212.216.176.33]:23242 "EHLO fep02-svc.tin.it")
	by vger.kernel.org with ESMTP id <S132578AbRDKOYT> convert rfc822-to-8bit;
	Wed, 11 Apr 2001 10:24:19 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
From: lomarcan@tin.it
Reply-To: lomarcan@tin.it
Subject: Re: SCSI tape corruption problem
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010411142412.IUNQ2878.fep02-svc.tin.it@fep41-svc.tin.it>
Date: Wed, 11 Apr 2001 16:24:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This seems to happen on my system too but I have and IDE tape:

Seems uncurrelated. I'm trying this:

# cd ~archive; tar cvzf /dev/tapes/tape0 # using devfs on rewinding dev
(some 600MB of stuff...)

where ~archive is on a SCSI drive (ext2 fs on LVM volume if can help)

# tar tvzf /dev/tapes/tape0
... some stuff pass correctly...

then gzip give a CRC error (no tape errors in syslog)

tape0 is on scsi0 (2904), the disk is on scsi1 (2940UW). Seems that the
problem is writing, because I get the CRC error always at the same point

				-- Lorenzo Marcantonio

