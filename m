Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUEFHzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUEFHzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 03:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUEFHzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 03:55:51 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:14608 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261300AbUEFHzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 03:55:50 -0400
Date: Thu, 6 May 2004 08:55:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       akpm@osdl.org
Subject: Re: Force IDE cache flush on shutdown
Message-ID: <20040506085549.A13098@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
	B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org
References: <20040506070449.GA12862@devserv.devel.redhat.com> <20040506084918.B12990@infradead.org> <20040506075044.GC12862@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040506075044.GC12862@devserv.devel.redhat.com>; from arjanv@redhat.com on Thu, May 06, 2004 at 09:50:44AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 09:50:44AM +0200, Arjan van de Ven wrote:
> > Please don't use reboot notifiers in new driver code.  The driver
> > model has a ->shutdown method for that.
> 
> there is somewhat of a problem with that; the reboot command potentially
> runs from the disk in question, so that might never get called since that
> will keep things busy.

shutdown != remove.  Shutdown is called for all devices on shutdown, remove
isn't called at all at reboot.

