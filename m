Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbSJGUA1>; Mon, 7 Oct 2002 16:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbSJGT7x>; Mon, 7 Oct 2002 15:59:53 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:13044 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262699AbSJGT7r>; Mon, 7 Oct 2002 15:59:47 -0400
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
	3.0 -  (NUMA))
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Daniel Phillips <phillips@arcor.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0210071145120.1356-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0210071145120.1356-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 21:14:29 +0100
Message-Id: <1034021669.26502.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 19:51, Linus Torvalds wrote:
> In the meantime, it might just be possible to take a look at the uid, and 
> if the uid matches use find_group_other, but for non-matching uids use 
> find_group_dir. That gives a "compact for same users, distribute for 
> different users" heuristic, which might be acceptable for normal use (and 
> the theoretical cleanup tool could fix it up).

Factoring the uid/gid/pid in actually may help in other ways. If we are
doing it by pid or by uid we will reduce the interleave of multiple
files thing you sometimes get

