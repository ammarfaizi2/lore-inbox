Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUFJWHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUFJWHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 18:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUFJWHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 18:07:10 -0400
Received: from mailadmin.WKU.EDU ([161.6.18.52]:25293 "EHLO mailadmin.wku.edu")
	by vger.kernel.org with ESMTP id S263117AbUFJWHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 18:07:04 -0400
From: "Bikram Assal" <bikram.assal@wku.edu>
Subject: ENOMEM in do_get_write_access, retrying
To: Burton Windle <bwindle@fint.org>, linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro WebUser Interface v.4.1.8
Date: Thu, 10 Jun 2004 17:07:04 -0500
Message-ID: <web-68590618@mailadmin.wku.edu>
In-Reply-To: <Pine.LNX.4.58.0406101737090.959@morpheus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kernel version installed on the server is 2.4.18-5

Would that be a problem ? Do I need to upgrade my kernel ?

Since the memory doesn't seem to be a problem apparently, what should be my next step to check the flaw.

Although this happened only once, this could lead to a possible problem.

Thanks a lot for your help.

- Bikram.


On Thu, 10 Jun 2004 17:39:33 -0400 (EDT)
 Burton Windle <bwindle@fint.org> wrote:
> On Thu, 10 Jun 2004, Bikram Assal wrote:
> 
> > Hi,
> >
> > I got this error in /var/log/messages only one time.
> > the error is : ENOMEM in do_get_write_access, retrying.
> >
> > Please help me find out the cause of it.
> >
> >
> > - Bikram
> > OCA ( Oracle Certified Associate )
> > Database Specialist, WKU
> > http://www.wku.edu/~bikram.assal/
> > -
> 
> That message comes from line 1598 in linux/fs/jbd/journal.c
> 
> It happens if the kernel tries to allocate memory for a journal (ext3)
> operation, but fails because there isn't any memory free currently.
> 
> With as much memory cached as you reported, this shouldn't happen.
> 
> --
> Burton Windle                           bwindle@fint.org
> 

- Bikram 
OCA ( Oracle Certified Associate )
Database Specialist, WKU
http://www.wku.edu/~bikram.assal/
