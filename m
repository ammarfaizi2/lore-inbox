Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265186AbSJWTqn>; Wed, 23 Oct 2002 15:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbSJWTqn>; Wed, 23 Oct 2002 15:46:43 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:61967
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265186AbSJWTqT>; Wed, 23 Oct 2002 15:46:19 -0400
Subject: Re: [PATCH] niceness magic numbers, 2.4.20-pre11
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Kristis Makris <devcore@freeuk.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1035360961.4033.0.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.33L2.0210222332480.15859-100000@dragon.pdx.osdl.net> 
	<1035360961.4033.0.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 15:52:52 -0400
Message-Id: <1035402772.3171.1550.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 04:16, Alan Cox wrote:

> On Wed, 2002-10-23 at 07:37, Randy.Dunlap wrote:
> > --- ./include/linux/resource.h.nice	Tue Jun 18 20:10:36 2002
> > +++ ./include/linux/resource.h	Sat Oct 19 13:55:10 2002
> > @@ -43,7 +43,7 @@
> >  };
> > 
> >  #define	PRIO_MIN	(-20)
> > -#define	PRIO_MAX	20
> > +#define	PRIO_MAX	19
> 
> I suspect this isnt correct

Agreed.  Its not.

It should remain 20 and places that truly want 19 should do PRIO_MAX-1.

The idea of cleaning up the magic numbers is fine, otherwise..

	Robert Love

