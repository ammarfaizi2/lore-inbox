Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWCFI1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWCFI1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbWCFI1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:27:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56791 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750942AbWCFI1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:27:24 -0500
Subject: Re: 9pfs double kfree
From: Arjan van de Ven <arjan@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Al Viro <viro@ftp.linux.org.uk>, Dave Jones <davej@redhat.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, rminnich@lanl.gov
In-Reply-To: <84144f020603060023s236c7221i3d6b20b6c7132ef4@mail.gmail.com>
References: <20060306070456.GA16478@redhat.com>
	 <20060305.230711.06026976.davem@davemloft.net>
	 <20060306072346.GF27946@ftp.linux.org.uk>
	 <20060306072823.GF21445@redhat.com>
	 <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com>
	 <20060306081651.GG27946@ftp.linux.org.uk>
	 <84144f020603060023s236c7221i3d6b20b6c7132ef4@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 09:27:13 +0100
Message-Id: <1141633633.5568.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 10:23 +0200, Pekka Enberg wrote:
> On 3/6/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> > Legal, but rather bad taste.  Init to NULL, possibly assign the value
> > if kmalloc(), then kfree() unconditionally - sure, but that... almost
> > certainly one hell of a lousy cleanup logics somewhere.
> 
> Agreed.

btw slab already detects double free()s. That doesn't mean this idea is
useless; it'll catch stuff, but it's not for pure finding double free ;)

