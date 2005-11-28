Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVK1Qzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVK1Qzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 11:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVK1Qzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 11:55:40 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24776 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751303AbVK1Qzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 11:55:39 -0500
Date: Mon, 28 Nov 2005 11:55:10 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: How can I prevent MTD to access the end of a flash device ?
In-reply-to: <cda58cb80511240032q7e4fbc67l@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Franck <vagabon.xyz@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0511281151010.6022@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <cda58cb80511070248o6d7a18bex@mail.gmail.com>
 <cda58cb80511220658n671bc070v@mail.gmail.com>
 <Pine.LNX.4.64.0511221042560.6022@localhost.localdomain>
 <cda58cb80511240032q7e4fbc67l@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2005, Franck wrote:

> > Yes.  It was tested on ARM only though.  Some architectures like i386
> > for example might need special tricks to implement this.
> >
> 
> do you know why ?

Apparently i386 might have issues having two virtual mappings for the 
same physical address range.  This can be worked around in the map 
driver by relying on the knowledge of flash aliases on the bus.

> What was the gain on ARM ?

The ability to use burst transfers which are only activated with cached 
memory, hence twice the read speed or more.


Nicolas
