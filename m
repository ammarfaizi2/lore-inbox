Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270384AbTGWPVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 11:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270386AbTGWPVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 11:21:21 -0400
Received: from rth.ninka.net ([216.101.162.244]:49792 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S270384AbTGWPVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 11:21:19 -0400
Date: Wed, 23 Jul 2003 08:36:21 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dgk@research.att.com, linux-kernel@vger.kernel.org, gsf@research.att.com,
       netdev@oss.sgi.com
Subject: Re: kernel bug in socketpair()
Message-Id: <20030723083621.26429e51.davem@redhat.com>
In-Reply-To: <1058970007.5520.68.camel@dhcp22.swansea.linux.org.uk>
References: <200307231332.JAA26197@raptor.research.att.com>
	<1058970007.5520.68.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jul 2003 15:20:08 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mer, 2003-07-23 at 14:32, David Korn wrote:
> > The first problem is that files created with socketpair() are not accessible
> > via /dev/fd/n or /proc/$$/fd/n where n is the file descriptor returned
> > by socketpair().  Note that this is not a problem with pipe().
> 
> This is intentional - sockets do not have an "open" operation currently.

Sure, but we've known this for a long time.

And because we knew, we decided not to add an "open"
method to sockets.  The reason, as I remember it, was
security.

Was it not?
