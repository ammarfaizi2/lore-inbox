Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbTCHNzI>; Sat, 8 Mar 2003 08:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbTCHNzI>; Sat, 8 Mar 2003 08:55:08 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52658
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262019AbTCHNzH>; Sat, 8 Mar 2003 08:55:07 -0500
Subject: Re: [PATCH] register_blkdev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, hch@infradead.org, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030308005018.GE23071@kroah.com>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl>
	 <20030307193644.A14196@infradead.org>
	 <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com>
	 <20030307143319.2413d1df.akpm@digeo.com> <20030307234541.GG21315@kroah.com>
	 <1047086062.24215.14.camel@irongate.swansea.linux.org.uk>
	 <20030308005018.GE23071@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047136302.25932.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 08 Mar 2003 15:11:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-08 at 00:50, Greg KH wrote:
> > So we need a maxminors flag in the register for 2.6 I guess ?
> 
> Do you mean to only increase the number of majors, and not minors then?

How about an interface that looks like

	register_chr_device(blah. blah, MY_MAX_MINOR);

and we can delete all the if < 0 || >= MAX return logic from the drivers
as we go. Right now each driver checks and several in the past had off 
by one errors.


