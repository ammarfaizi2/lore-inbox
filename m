Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUKWIw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUKWIw5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 03:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbUKWIuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 03:50:32 -0500
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:62828 "EHLO
	ash.lnxi.com") by vger.kernel.org with ESMTP id S262339AbUKWItV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 03:49:21 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Roland Dreier <roland@topspin.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
References: <20041122714.taTI3zcdWo5JfuMd@topspin.com>
	<20041122714.AyIOvRY195EGFTaO@topspin.com>
	<20041122153144.GA4821@infradead.org>
From: ebiederman@lnxi.com (Eric W. Biederman)
Date: 23 Nov 2004 01:49:16 -0700
In-Reply-To: <20041122153144.GA4821@infradead.org>
Message-ID: <m37jodlzlf.fsf@maxwell.lnxi.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> > +  When the IPoIB driver is loaded, it creates one interface for each
> > +  port using the P_Key at index 0.  To create an interface with a
> > +  different P_Key, write the desired P_Key into the main interface's
> > +  /sys/class/net/<intf name>/create_child file.  For example:
> > +
> > +    echo 0x8001 > /sys/class/net/ib0/create_child
> > +
> > +  This will create an interface named ib0.8001 with P_Key 0x8001.  To
> > +  remove a subinterface, use the "delete_child" file:
> > +
> > +    echo 0x8001 > /sys/class/net/ib0/delete_child
> > +
> > +  The P_Key for any interface is given by the "pkey" file, and the
> > +  main interface for a subinterface is in "parent."
> 
> Any reason this doesn't use an interface similar to the normal vlan code?
> 
> And what is a P_Key?

IB version of a vlan identifier.

Eric
