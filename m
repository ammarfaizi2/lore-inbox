Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEMp0>; Fri, 5 Jan 2001 07:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAEMpQ>; Fri, 5 Jan 2001 07:45:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6405 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129183AbRAEMo6>; Fri, 5 Jan 2001 07:44:58 -0500
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
To: adilger@turbolinux.com (Andreas Dilger)
Date: Fri, 5 Jan 2001 12:46:19 +0000 (GMT)
Cc: phillips@innominate.de (Daniel Phillips),
        sct@redhat.com (Stephen C. Tweedie), linux-kernel@vger.kernel.org
In-Reply-To: <200101050800.f0580He12396@webber.adilger.net> from "Andreas Dilger" at Jan 05, 2001 01:00:17 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EWGE-0007bW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unless Stephen says otherwise, my understanding is that a crash during
> journal recovery will just mean the journal is replayed again at the next
> recovery.  Because the ext3 journal is just a series of data blocks to
> be copied into the filesystem (rather than "actions" to be done), it
> doesn't matter how many times it is done.  The recovery flags are not
> reset until after the journal replay is completed.

Which means an ext3 volume cannot be recovered on a hard disk error. 

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
