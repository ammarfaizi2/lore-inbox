Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVEGABR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVEGABR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 20:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVEGABR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 20:01:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34476 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261318AbVEFX6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:58:30 -0400
Date: Fri, 6 May 2005 19:57:22 -0400
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, Ken Pizzini <ken@halcyon.com>,
       Ron Jeppesen <ronj.an@site007.saic.com>,
       Corey Minyard <minyard@wf-rch.cirr.com>, akpm@osdl.org
Subject: Re: [PATCH] remove pointless NULL check before kfree in sony535.c
Message-ID: <20050506235722.GB825@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
	Ken Pizzini <ken@halcyon.com>,
	Ron Jeppesen <ronj.an@site007.saic.com>,
	Corey Minyard <minyard@wf-rch.cirr.com>, akpm@osdl.org
References: <Pine.LNX.4.62.0505070114160.2384@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505070114160.2384@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 01:19:01AM +0200, Jesper Juhl wrote:
 > --- linux-2.6.12-rc3-mm3-orig/drivers/cdrom/sonycd535.c	2005-03-02 08:38:37.000000000 +0100
 > +++ linux-2.6.12-rc3-mm3/drivers/cdrom/sonycd535.c	2005-05-07 01:13:30.000000000 +0200
 > @@ -1605,7 +1605,6 @@ out7:
 >  	put_disk(cdu_disk);
 >  out6:
 >  	for (i = 0; i < sony_buffer_sectors; i++)
 > -		if (sony_buffer[i]) 
 >  			kfree(sony_buffer[i]);
 >  out5:

This breaks the indentation.

		Dave
