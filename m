Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264535AbUFNWJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbUFNWJA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 18:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUFNWJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 18:09:00 -0400
Received: from gate.firmix.at ([80.109.18.208]:62910 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S264535AbUFNWI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 18:08:58 -0400
Subject: Re: upcalls from kernel code to user space daemons
From: Bernd Petrovitsch <bernd@firmix.at>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Oliver Neukum <oliver@neukum.org>, Steve French <smfltc@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40CE1F42.1020407@nortelnetworks.com>
References: <200406142341.13340.oliver@neukum.org>
	 <40CE1F42.1020407@nortelnetworks.com>
Content-Type: text/plain
Organization: http://www.firmix.at/
Message-Id: <1087250925.8828.3.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 15 Jun 2004 00:08:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-14 at 23:57, Chris Friesen wrote:
> Oliver Neukum wrote:
> 
> >  > userspace daemon loops on ioctl()
> >  > kernel portion of ioctl call goes to sleep until something to do
> >  > when needed, fill in data and return to userspace
> >  > userspace does stuff, then passes data back down via ioctl()
> >  > ioctl() puts userspace back to sleep and continues on with other work
> > 
> > You could just as well implement an ordinary read()
> 
> Not quite.  The userspace is passing data down as well.  I don't know how you'd 
> do that with read().

For this you use write().

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


