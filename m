Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161347AbWJ3SpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161347AbWJ3SpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161344AbWJ3SpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:45:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12769 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030572AbWJ3SpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:45:23 -0500
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <jens.axboe@oracle.com>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
In-Reply-To: <454644C1.4080702@rtr.ca>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk>
	 <1162220239.2948.27.camel@laptopd505.fenrus.org>
	 <20061030154444.GH4563@kernel.dk>
	 <1162225002.2948.45.camel@laptopd505.fenrus.org>
	 <20061030162621.GK4563@kernel.dk>
	 <1162225915.2948.49.camel@laptopd505.fenrus.org>
	 <20061030175224.GB14055@kernel.dk> <45463C5B.7070900@rtr.ca>
	 <45464064.2090108@rtr.ca> <20061030181645.GF14055@kernel.dk>
	 <454644C1.4080702@rtr.ca>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 30 Oct 2006 19:45:18 +0100
Message-Id: <1162233918.2948.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (gdb) l *cfq_set_request+0x33e
> 0xc021780e is in cfq_set_request (block/cfq-iosched.c:1224).
> 1219            if (unlikely(!cfqd))
> 1220                    return;
> 1221
> 1222            spin_lock(cfqd->queue->queue_lock);

this looks interesting... and buggy ;)
(this is changed_ioprio() )

Jens?



