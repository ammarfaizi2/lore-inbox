Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVEXRMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVEXRMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVEXQ7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:59:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50072 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261327AbVEXQwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:52:47 -0400
Subject: Re: inotify 0.23 errno 28 (ENOSPC)
From: Arjan van de Ven <arjan@infradead.org>
To: Robert Love <rlove@rlove.org>
Cc: bryanwilkerson@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <1116952520.13324.38.camel@betsy>
References: <20050524163309.74541.qmail@web53401.mail.yahoo.com>
	 <1116952520.13324.38.camel@betsy>
Content-Type: text/plain
Date: Tue, 24 May 2005 18:52:35 +0200
Message-Id: <1116953555.6280.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-24 at 12:35 -0400, Robert Love wrote:
> On Tue, 2005-05-24 at 09:33 -0700, Bryan Wilkerson wrote:
> 
> > I read an earlier thread where you said that it was
> > possible to manually walk a tree and add all
> > directories to an inotify watch descriptor.  I wrote
> > some code to do this and the ioctl call fails on my
> > machine after adding 9,977 directories with ENOSPC.  
> > 
> > I've attached a small repro case.  Just point it at
> > the base of a large dir tree (e.g. inotify-r ~) to
> > use. 
> > 
> > My kernel is 2.6.12-rc3 with the inotify 0.23 patch. 
> > Let me know if you need more information.  
> 
> This is intended.  There is a per-user limit on the number of watches.
> By default, that limit is 8192.
> 
> You can view and edit the number via
> 	/sys/class/misc/inotify/max_user_watches

why isn't this an rlimit instead ?


