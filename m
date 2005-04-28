Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVD2JuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVD2JuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 05:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVD2JuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 05:50:15 -0400
Received: from s-utl01-lapop.stsn.com ([12.129.240.11]:37868 "HELO
	s-utl01-lapop.stsn.com") by vger.kernel.org with SMTP
	id S262225AbVD2JuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 05:50:04 -0400
Subject: Re: [06/07] [PATCH] SCSI tape security: require CAP_ADMIN for
	SG_IO etc.
From: Arjan van de Ven <arjan@infradead.org>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504280810140.12812@kai.makisara.local>
References: <20050427171446.GA3195@kroah.com>
	 <20050427171649.GG3195@kroah.com>
	 <1114619928.18809.118.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0504280810140.12812@kai.makisara.local>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 08:49:58 -0400
Message-Id: <1114692598.6068.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 08:43 +0300, Kai Makisara wrote:
> On Wed, 27 Apr 2005, Alan Cox wrote:
> 
> > On Mer, 2005-04-27 at 18:16, Greg KH wrote:
> > > -stable review patch.  If anyone has any objections, please let us know.
> > 
> > This patch is just wrong on so many different levels its hard to know
> > where to begin.
> > 
> > 1. The auth for arbitary commands is CAP_SYS_RAWIO
> 
> Valid complaint.
> 
> > 2. "The SCSI command permissions were discussed widely on the linux
> > lists but this did not result in any useful refinement of the
> > permissions." - this is false. The process was refined, a table setup
> > was added and debugged.
> 
> Any user having write access to the device is still allowed to send MODE 
> SELECT (and some other commands useful for CD/DVD writers but being 
> potentially dangerous to other). 

If you give your user *WRITE ACCESS* to the tape you expect him to be
able to do a lot of writing, right? The restrictions for *READ* are
obviously more clear...

> OK. If the Linux solution to these kind of security problems in the not so 
> central areas of kernel is to wait and see if the problem disappears 
> without any action, I have to accept that. But I have tried...

the security problem is giving someone write access to a device and then
somehow expect that to mean "selective write" ?




