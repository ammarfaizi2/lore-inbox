Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRBZVQV>; Mon, 26 Feb 2001 16:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBZVQM>; Mon, 26 Feb 2001 16:16:12 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14345 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129143AbRBZVP6>; Mon, 26 Feb 2001 16:15:58 -0500
Subject: Re: PROBLEM: ramfs causes system hang when swapping
To: nobbi@cheerful.com
Date: Mon, 26 Feb 2001 21:18:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010226220338.A1558@DeepThought> from "Norbert Nemec" at Feb 26, 2001 10:03:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XV2q-0001zj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a ramfs mounted as /tmp. When I create a large file:
> 
>     dd if=/dev/zero of=/tmp/xxx bs=1024K count=200
>     
> (with 128M RAM), the complete system comes to a halt. Hitting keys does not do 

RAMfs doesnt use swap. It also in 2.4.2 doesnt have limits. The -ac one uses
limits so will stop you totally running the box out of ram. 2.4ac also has
the true tmpfs with swap backing
