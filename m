Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVBMSta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVBMSta (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 13:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVBMSta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 13:49:30 -0500
Received: from smtpout6.uol.com.br ([200.221.4.197]:47746 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261162AbVBMStZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 13:49:25 -0500
Date: Sun, 13 Feb 2005 16:49:24 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [Partially solved] Re: irq 10: nobody cared! (was: Re: 2.6.11-rc3-mm1)
Message-ID: <20050213184924.GB4614@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	B.Zolnierkiewicz@elka.pw.edu.pl
References: <20050204103350.241a907a.akpm@osdl.org> <20050205224558.GB3815@ime.usp.br> <20050212222104.GA1965@node1.opengeometry.net> <20050212224715.GA8249@ime.usp.br> <20050212232134.GA2242@node1.opengeometry.net> <20050212235043.GA4291@ime.usp.br> <20050213014151.GA2735@node1.opengeometry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050213014151.GA2735@node1.opengeometry.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, William.

On Feb 12 2005, William Park wrote:
> Your 'dmesg' says
>     Warning: Secondary channel requires an 80-pin cable for operation.
> I assume it is.

Well, I just finished compiling the 2.6.11-rc4 kernel and the problem
persisted. This time, I enabled ACPI debugging and it indeed generates more
details.

Right after the problem persisted, I turned off the second HD (which was
the master of the secondary channel of the Promise controller) and the
problem automagically went away. :-(

One other thing is that the BIOS still configures the drive as UDMA 4, but
Linux downgrades that to UDMA 2. I'm not sure why.

Using hdparm manually with "hdparm -c1 -u1 -d1 -X udma4 /dev/hde" enables
things that the kernel doesn't and seems to be working wonderfully.

I don't know what I should do right now. I have put the newer dmesg logs on
<http://www.ime.usp.br/~rbrito/ide-problem/>. Should I contact anybody else?
I do need the second drive on, though.

I'm CC'ing Bartlomiej Zolnierkiewicz, as he is listed in the MAINTAINERS
file as the IDE maintainer.


Thanks for any comments and help, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
