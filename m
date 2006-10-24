Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161189AbWJXTLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWJXTLO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWJXTLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:11:14 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:45515 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161189AbWJXTLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:11:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Tue, 24 Oct 2006 21:09:41 +0200
User-Agent: KMail/1.9.1
Cc: David Chinner <dgc@sgi.com>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, xfs@oss.sgi.com
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610241730.00488.rjw@sisk.pl> <20061024170633.GA17956@infradead.org>
In-Reply-To: <20061024170633.GA17956@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610242109.42301.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 October 2006 19:06, Christoph Hellwig wrote:
> On Tue, Oct 24, 2006 at 05:29:59PM +0200, Rafael J. Wysocki wrote:
> > Do you mean calling sys_sync() after the userspace has been frozen
> > may not be sufficient?
> 
> No, that's definitly not enough.  You need to freeze_bdev to make sure
> data is on disk in the place it's expected by the filesystem without
> starting a log recovery.

Thanks for the clarification.

Then it looks like we need the freezing of bdevs.  Pavel?


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
