Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282413AbRL1Qw2>; Fri, 28 Dec 2001 11:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282511AbRL1QwS>; Fri, 28 Dec 2001 11:52:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53257 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282413AbRL1QwE>; Fri, 28 Dec 2001 11:52:04 -0500
Subject: Re: 2.4.17 absurd number of context switches
To: jwb@saturn5.com (Jeffrey W. Baker)
Date: Fri, 28 Dec 2001 17:02:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112280824550.23655-100000@windmill.gghcwest.com> from "Jeffrey W. Baker" at Dec 28, 2001 08:35:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16K0OX-00015u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Check out those figures for context switches!  30,000 switches per second
> with only three runnable processes and practically no block I/O seems
> quite high to me.  You can also see that the system is spending half its
..
> Is this a scheduler worst-case, something to be expected, or something I
> can work around?

The scheduler is _good_ at the three process case. Run some straces it looks
more like postgres is doing wacky yield based locks.

Alan
