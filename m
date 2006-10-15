Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWJORTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWJORTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 13:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWJORTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 13:19:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39827 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751153AbWJORTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 13:19:15 -0400
Subject: Re: [v4l-dvb-maintainer] [PATCH] V4L/DVB: potential leak in
	dvb-bt8xx
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Manu Abraham <abraham.manu@gmail.com>
Cc: Florin Malita <fmalita@gmail.com>, Trent Piepho <xyzzy@speakeasy.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <45326359.4000502@gmail.com>
References: <453120EC.8030503@gmail.com>
	 <Pine.LNX.4.58.0610141720560.13331@shell2.speakeasy.net>
	 <45325B9E.1030808@gmail.com>  <45326359.4000502@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 15 Oct 2006 14:18:35 -0300
Message-Id: <1160932715.5364.1.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2006-10-15 às 20:35 +0400, Manu Abraham escreveu:
> Florin Malita wrote:
> > Trent Piepho wrote:
> >> I believe that 'state' will be kfree'd by the dst_attach() function if there
> >> is a failure.  Not what you would expect, to have it allocated in the bt8xx
> >> driver (why do is there??) and freed on error in a different function.
> >>   
> > 
> > Hm, you're right - it is kfreed in dst_attach(). But we're still missing
> > the kmalloc result check...
> > 
> 
> This patch was applied a few days back

Yes. 

It is at:
http://www.kernel.org/git/?p=linux/kernel/git/mchehab/v4l-dvb.git;a=commit;h=626ae83bb24927ca015503448f0199842ae2e8da

I've already asked Linus to pull it, together with other 17 fixes, to
Mainstream.
> 
> Manu
Cheers, 
Mauro.

