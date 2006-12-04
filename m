Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937029AbWLDPiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937029AbWLDPiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937031AbWLDPiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:38:10 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:53335 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937029AbWLDPiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:38:09 -0500
Message-ID: <45744101.2040904@cfl.rr.com>
Date: Mon, 04 Dec 2006 10:38:41 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-aio@kvack.org,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: slow io_submit
References: <5d96567b0612010904s361b799t8db72accc287ca54@mail.gmail.com>  <20061201172749.GZ5400@kernel.dk> <5d96567b0612011340m410a2294w9b02b619a62888da@mail.gmail.com>
In-Reply-To: <5d96567b0612011340m410a2294w9b02b619a62888da@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2006 15:38:18.0220 (UTC) FILETIME=[3879A2C0:01C717BA]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14852.003
X-TM-AS-Result: No--6.465700-5.000000-4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raz Ben-Jehuda(caro) wrote:
> Who returns EGAIN to whom ?   I am not sure i understand what you mean 
> here.

If the queue is full then io_sumbit() should return EAGAIN or some other 
error to indicate that the queue is full, but right now it just blocks 
instead.


