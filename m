Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVEBEZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVEBEZY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 00:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVEBEZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 00:25:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53690 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261560AbVEBEZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 00:25:19 -0400
Date: Sun, 1 May 2005 21:24:38 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Support multiply-LUN devices in ub
Message-Id: <20050501212438.08ae67f1.zaitcev@redhat.com>
In-Reply-To: <20050502040505.GA6914@one-eyed-alien.net>
References: <20050501160540.5b2f4e61.zaitcev@redhat.com>
	<20050502040505.GA6914@one-eyed-alien.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 May 2005 21:05:05 -0700, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> On Sun, May 01, 2005 at 04:05:40PM -0700, Pete Zaitcev wrote:

> >  /*
> > + * This many LUNs per USB device.
> > + * Every one of them takes a host, see UB_MAX_HOSTS.
> >   */
> > +#define UB_MAX_LUNS   4
> 
> Why only 4 LUNs?

This can be redefined at any moment, fortunately, so there's no need to
agonize over this number. There is no backward or forward compatibility
problem. The sole purpose of that limit is to make a probe loop bound,
for initial testing.

Why would you want more though? I have a 12-in-1 reader which only
exports 4 LUNs. If someone attached enterprise storage arrays to USB,
it might be a good idea to remove the limit completely.

-- Pete
