Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272790AbTHPGfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 02:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272791AbTHPGfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 02:35:24 -0400
Received: from dsl017-022-215.chi1.dsl.speakeasy.net ([69.17.22.215]:1289 "EHLO
	gateway.two14.net") by vger.kernel.org with ESMTP id S272790AbTHPGfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 02:35:20 -0400
Date: Sat, 16 Aug 2003 01:35:12 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: maney@pobox.com, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
Message-ID: <20030816063512.GA1075@furrr.two14.net>
Reply-To: maney@pobox.com
References: <20030812213645.GA1079@furrr.two14.net> <Pine.LNX.4.44.0308131155090.4279-100000@localhost.localdomain> <20030813181330.GA1122@furrr.two14.net> <1060803612.9130.37.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060803612.9130.37.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: maney@two14.net (Martin Maney)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 08:40:13PM +0100, Alan Cox wrote:
> I think the real thing is to find the bug. I guess pdc202xx_old.c needs
> an audit at this point.

I've got no problem with that, of course.  I guess I was thinking
pessimistic thoughts about finding a fix for this for .22

> > driver only talks about a 66MHz high speed; does that mean that the
> > 20265 never gets run at its full speed under Linux, or is it just old
> > terminology from back when UDMA66 was the top speed?
> 
> The latter. 

So what I'm seeing is a failure at 100MHz operation.  Is there any way
to put the Promise into 66MHz mode (other than using a drive that runs
no faster)?  Because at this point I don't have any practical way to
rule out the possibility that the cable/drive are what's marginal at
100MHz; aside from the Promise, I don't have anything faster than a
UDMA66 card (which works fine with them).

I also managed to find a useful non-broken link on ASUS's web site and
found that they had snuck out a BIOS update later than the latest I had
previously known of, and it did include a minor change in the Promise
BIOS (from 2.01 build 19 to build 35).  Made no difference, though: the
50MB copy still failed as usual with 22-rc2.

-- 
The Internet discourages reflection and deep thought. It
encourages just glossing over, as quick as possible. The
Internet is a terrific way to look up facts and a terrible
way to get a story.  -- Clifford Stoll
                                          
