Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263432AbTH2UYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 16:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbTH2UGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 16:06:25 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:64010 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261562AbTH2UBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 16:01:24 -0400
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] s390 (5/8): common i/o layer.
References: <20030829171005.GF1242@mschwid3.boeblingen.de.ibm.com>
	<87vfsggtb2.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 30 Aug 2003 05:01:05 +0900
In-Reply-To: <87vfsggtb2.fsf@devron.myhome.or.jp>
Message-ID: <87ptio1bem.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> > @@ -537,8 +537,7 @@
> >  	init_timer(&cdev->private->timer);
> >  
> >  	/* Set an initial name for the device. */
> > -	snprintf (cdev->dev.name, DEVICE_NAME_SIZE,"ccw device");
> > -	snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0:%04x",
> > +	snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0.0.%04x",
> >  		  sch->schib.pmcw.dev);
> >  
> >  	/* Increase counter of devices currently in recognition. */
> 
> Shouldn't the above use BUS_ID_SIZE instead of DEVICE_ID_SIZE?

Ooops. Sorry, I miss read it. I thought it's DEVICE_NAME_SIZE.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
