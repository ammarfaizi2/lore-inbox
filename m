Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbTLYQ6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 11:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbTLYQ6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 11:58:42 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3200 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264326AbTLYQ6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 11:58:41 -0500
Date: Thu, 25 Dec 2003 17:04:26 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312251704.hBPH4QnO000128@81-2-122-30.bradfords.org.uk>
To: Bart Samwel <bart@samwel.tk>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3FEAFE66.2020602@samwel.tk>
References: <3FE92517.1000306@samwel.tk>
 <20031224111640.GL1601@suse.de>
 <3FE9AFFC.2080302@samwel.tk>
 <20031225100648.GB13382@conectiva.com.br>
 <3FEAFE66.2020602@samwel.tk>
Subject: Re: [PATCH] laptop-mode for 2.6, version 4 + smart_spindown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've got another problem getting this stuff to work. The problem lies 
> with my HD: it just doesn't respect the spindown time, I've got it set 
> to hdparm -S 4 and it just doesn't spin down, even though there's no 
> activity whatsoever! hdparm -B 254 gives me:
> 
> /dev/hdb:
>   setting Advanced Power Management level to 0xFE (254)
>   HDIO_DRIVE_CMD failed: Input/output error
> 
> It's funny, because hdparm -I gives me:
> 
> Commands/features:
>          Enabled Supported:
> [...]
>             *    Power Management feature set
> 
> So, it should support this. Apparently it doesn't. :( The drive is a WD 
> 800BB. Does anyone have any clue what could cause this?

No, but I've definitely seen other drives, (old Toshiba ~100 MB ones),
which respect 'spin down immediately' commands, and don't support the
spin down inactivity timer.  I can't remember whether they report
Power Management feature set supported or not, though.

John.
