Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbUBTSML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbUBTSML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:12:11 -0500
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:11400 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S261369AbUBTSLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:11:53 -0500
Date: Fri, 20 Feb 2004 19:11:46 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] 2/6 POSIX message queues
In-Reply-To: <200402201455.25782.arnd@arndb.de>
Message-ID: <Pine.GSO.4.58.0402201848380.10845@Juliusz>
References: <200402201455.25782.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004, Arnd Bergmann wrote:

> Krzysztof Benedyczak wrote:
>
> > +
> > +struct mq_attr {
> > +	long	mq_flags;	/* message queue flags			*/
> > +	long	mq_maxmsg;	/* maximum number of messages		*/
> > +	long	mq_msgsize;	/* maximum message size			*/
> > +	long	mq_curmsgs;	/* number of messages currently queued	*/
> > +};
> > +
>
> Does POSIX mandate that these have to be 'long'? If you can change them
> all to any of 'int', '__s32' or '__s64', the handlers for 32 bit system
> call emulation on 64 bit machines will get a lot simpler because the
> 32 bit user structures are then identical to the 64 bit ones.
>
Yes, POSIX defines it to longs. And quess that compability issues should
be handled in kernel?

Krzysztof Benedyczak
