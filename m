Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSE0OXq>; Mon, 27 May 2002 10:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316635AbSE0OXp>; Mon, 27 May 2002 10:23:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39421 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316632AbSE0OXn> convert rfc822-to-8bit; Mon, 27 May 2002 10:23:43 -0400
Subject: Re: Memory management in Kernel 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Andreas Hartmann <andihartmann@freenet.de>, linux-kernel@vger.kernel.org
In-Reply-To: <3CF23893.207@loewe-komp.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 16:25:56 +0100
Message-Id: <1022513156.1126.289.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 14:45, Peter Wächtler wrote:
> There is still the oom killer (Out Of Memory).
> But it doesn't trigger and the machine pages "forever".
> Usually kswapd eats the CPU then, discarding and reloading pages,
> searching lists for pages to evict and so on.

On a -ac kernel with mode 2 or 3 set for overcommit you have to run out
of kernel resources to hang the box. It won't go OOM because it can't.
That wouldn't be a VM bug but a leak or poor handling of kernel
allocations somewhere. Sadly the changes needed to do that (beancounter
patch) were things Linus never accepted for 2.4

