Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132242AbRCVX3j>; Thu, 22 Mar 2001 18:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132246AbRCVX3d>; Thu, 22 Mar 2001 18:29:33 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:39536 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S132241AbRCVX2f>;
	Thu, 22 Mar 2001 18:28:35 -0500
Message-ID: <20010323002752.A5650@win.tue.nl>
Date: Fri, 23 Mar 2001 00:27:52 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stephenc@theiqgroup.com (Stephen Clouse),
        riel@conectiva.com.br (Rik van Riel),
        orourke@missioncriticallinux.com (Patrick O'Rourke),
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010322230041.A5598@win.tue.nl> <E14gDwB-0003Tj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E14gDwB-0003Tj-00@the-village.bc.nu>; from Alan Cox on Thu, Mar 22, 2001 at 10:52:09PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 10:52:09PM +0000, Alan Cox wrote:

> > You see, the bug is that malloc does not fail. This means that the
> > decisions about what to do are not taken by the program that knows
> > what it is doing, but by the kernel.

> Even if malloc fails the situation is no different.

Why do you say so?

> You can do overcommit avoidance in Linux if you are bored enough to try it.

Would you accept it as the default? Would Linus?

(With disk I/O we are terribly conservative, using very cautious settings,
and many people use hdparm to double or triple their disk speed.
But for a few these optimistic settings cause data corruption,
so we do not make it the default.
Similarly I would be happy if the "no overcommit", "no OOM killer"
situation was the default. The people who need a reliable system
will leave it that way. The people who do not mind if some process
is killed once in a while use vmparm or /proc/vm/overcommit or so
to make Linux achieve more on average.)

Andries
