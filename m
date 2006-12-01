Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967674AbWLAR1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967674AbWLAR1X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758823AbWLAR1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:27:22 -0500
Received: from brick.kernel.dk ([62.242.22.158]:23374 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1758520AbWLAR1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:27:22 -0500
Date: Fri, 1 Dec 2006 18:27:49 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: linux-aio@kvack.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       suparna@in.ibm.com
Subject: Re: slow io_submit
Message-ID: <20061201172749.GZ5400@kernel.dk>
References: <5d96567b0612010904s361b799t8db72accc287ca54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d96567b0612010904s361b799t8db72accc287ca54@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01 2006, Raz Ben-Jehuda(caro) wrote:
> Jens suparna hello
> 
> I have managed to understand why io_submit is sometimes very slow.
> It is because the device is plugged once too many io's are being sent.
> I have conducted a simple test with nr_request to default value of 128
> and and 256.
> and it proved to be correct.

I don't understand your email. The device is plugged when it is empty,
not when it has emptied the request list.

> I would truely appreciate your comment on this.

On what? :-)

If it's no blocking and returning EAGAIN instead, then I agree this is
what should eventually happen. Right now nobody is working on that
afaik, so it's not something that will hit the next kernel.

-- 
Jens Axboe

