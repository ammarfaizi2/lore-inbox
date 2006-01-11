Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWAKJvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWAKJvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWAKJvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:51:16 -0500
Received: from f24.mail.ru ([194.67.57.160]:22541 "EHLO f24.mail.ru")
	by vger.kernel.org with ESMTP id S1751424AbWAKJvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:51:15 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re[2]: [PATCH]trivial: add CDC_RAM to ide-cd capabilities mask
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Wed, 11 Jan 2006 12:51:12 +0300
In-Reply-To: <20060111092937.GS3389@suse.de>
Reply-To: Andrey Borzenkov <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1EwcdM-000LWK-00.arvidjaar-mail-ru@f24.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Jens Axboe <axboe@suse.de>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Date: Wed, 11 Jan 2006 10:29:38 +0100
Subject: Re: [PATCH]trivial: add CDC_RAM to ide-cd capabilities mask

> 
> On Wed, Jan 11 2006, Andrey Borzenkov wrote:
> > 
> > 
> > > drive name:             sr0
> > > drive speed:            1
> > > drive # of slots:       1
> > > Can close tray:         1
> > > Can open tray:          1
> > > Can lock tray:          1
> > > Can change speed:       0
> > > Can select disk:        0
> > > Can read multisession:  1
> > > Can read MCN:           1
> > > Reports media changed:  1
> > > Can play audio:         1
> > > Can write CD-R:         0
> > > Can write CD-RW:        0
> > > Can read DVD:           0
> > > Can write DVD-R:        0
> > > Can write DVD-RAM:      0
> > > Can read MRW:           1
> > > Can write MRW:          1
> > > Can write RAM:          1
> > > 
> > > There's no way this drive knows anything about MRW or random-access writing:
> > > 
> > ...
> > > And an ATAPI DVD-ROM also reports (before the above patch):
> > > 
> > > Can read MRW:           1
> > > Can write MRW:          1
> > > Can write RAM:          1
> > > 
> > 
> > I know. There were patches from Jens for both 2.4 and 2.6 that add MRW
> > support to ide-cd for sure; may be for sr too, am not sure. Jens, any
> > reasons for them not in mainstream? Otherwise probably ide-cd and sr should
> > not announce MRW capabiliies at all, it is too confusing; I'll send a patch
> > when I am at home.
> 
> MRW support is in 2.6 since ages. The MRW flag is only detected on open,
> so it should disappear from the proc file once you have opened the
> drive. It has to be done that way, I'm afraid.
> 

I see, it is in generic cdrom code, sorry.

is it possible that drive supports MRW_W without supporting any other write
method (_R/_RW)? Should not ide-cd/sr - or possibly even cdrom - mask MRW_W
if they do not support writing at all?

thank you

-andrey
