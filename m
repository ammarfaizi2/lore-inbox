Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273016AbTHIQYF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 12:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273071AbTHIQYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 12:24:05 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:37764 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S273016AbTHIQYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 12:24:02 -0400
Date: Sat, 9 Aug 2003 17:23:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       albert@users.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       chip@pobox.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030809162332.GB29647@mail.jlokier.co.uk>
References: <1060087479.796.50.camel@cube> <20030809002117.GB26375@mail.jlokier.co.uk> <20030809081346.GC29616@alpha.home.local> <20030809015142.56190015.davem@redhat.com> <1060425774.4933.73.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060425774.4933.73.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > I believe the C language allows for systems where the NULL pointer is
> > not zero.

The representation is not zero, however in the C language (since ANSI,
not sure about K&R), 0 is a valid name for the NULL pointer whatever
its representation.

> > I can't think of any reason why the NULL macro exists otherwise.
> 
> <OldFart>
> NULL is really important in K&R C because you don't have prototypes and
> sizeof(foo *) may not be the same as sizeof(int). This leads to very
> nasty problems that people nowdays forget about.
> </OldFart>

Not just K&R.  These are different because of varargs:

	printf ("%p", NULL);
	printf ("%p", 0);

-- Jamie
