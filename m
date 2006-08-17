Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWHQOjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWHQOjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWHQOjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:39:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29348 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932513AbWHQOjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:39:09 -0400
Subject: Re: PATCH/FIX for drivers/cdrom/cdrom.c
From: Arjan van de Ven <arjan@infradead.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, 7eggert@gmx.de, Dirk <noisyb@gmx.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060817143633.GF13641@csclub.uwaterloo.ca>
References: <6Kxns-7AV-13@gated-at.bofh.it> <6Kytd-1g2-31@gated-at.bofh.it>
	 <6KyCQ-1w7-25@gated-at.bofh.it> <E1GDgyZ-0000jV-MV@be1.lrz>
	 <1155821951.15195.85.camel@localhost.localdomain>
	 <20060817132309.GX13639@csclub.uwaterloo.ca>
	 <1155822530.15195.95.camel@localhost.localdomain>
	 <20060817143633.GF13641@csclub.uwaterloo.ca>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 17 Aug 2006 16:38:41 +0200
Message-Id: <1155825521.4494.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 10:36 -0400, Lennart Sorensen wrote:
> On Thu, Aug 17, 2006 at 02:48:50PM +0100, Alan Cox wrote:
> > Ar Iau, 2006-08-17 am 09:23 -0400, ysgrifennodd Lennart Sorensen:
> > > Why can't O_EXCL mean that the kernel prevents anyone else from issuing
> > > ioctl's to the device?  One would think that is the meaning of exlusive.
> > 
> > If you were designing a new OS from scratch you might want to explore
> > that semantic as a design idea. I wouldn't recommend it because a lot of
> > apps will be upset if they issue an ioctl and it mysteriously fails or
> > hangs.
> 
> I think hal should get an error when it tries to open the cdrom device
> when the burning application is using it. 

this is what O_EXCL is for ;)


> Hmm, so how does one tell hal to go to hell and leave the cdrom device
> alone at all times (other than totally disabling hal). 

make sure hal uses O_EXCL, and if not, beat up the hal guys about it ;)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

