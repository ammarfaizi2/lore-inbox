Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132825AbRDITV7>; Mon, 9 Apr 2001 15:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132826AbRDITVt>; Mon, 9 Apr 2001 15:21:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13073 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132825AbRDITVg>; Mon, 9 Apr 2001 15:21:36 -0400
Subject: Re: Zero Copy IO
To: aqchen@us.ibm.com (Alex Q Chen)
Date: Mon, 9 Apr 2001 20:23:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF31086D36.2158EA0D-ON87256A28.008001ED@LocalDomain> from "Alex Q Chen" at Apr 08, 2001 04:31:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mhGR-0002ie-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> advantageous to enable zero copy IO than copy_from_user() and copy_to_user
> () all the data.  Other OS such as AIX and OS2 have kernel functions that
> can be used to accomplish such a task.  Has any ground work been done in
> Linux 2.4 to enable "zero copying IO"?

kiovecs support this. Note that the current kiovec has problems when it comes
to certain kinds of latency critical use and the 2.5 kernel meeting hashed out
some big changes here. But for 2.4 the kiovecs are there 
