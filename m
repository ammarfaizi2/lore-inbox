Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbTBNSfJ>; Fri, 14 Feb 2003 13:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTBNSfJ>; Fri, 14 Feb 2003 13:35:09 -0500
Received: from bitmover.com ([192.132.92.2]:36014 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261645AbTBNSfH>;
	Fri, 14 Feb 2003 13:35:07 -0500
Date: Fri, 14 Feb 2003 10:44:58 -0800
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Dillow <dillowd@y12.doe.gov>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 3Com 3cr990 driver release
Message-ID: <20030214184458.GA1488@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Dillow <dillowd@y12.doe.gov>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <3E4C9FAA.FC8A2DC7@y12.doe.gov> <1045233209.7958.11.camel@irongate.swansea.linux.org.uk> <20030214151920.GA3188@work.bitmover.com> <1045241640.1353.13.camel@irongate.swansea.linux.org.uk> <20030214160915.GC3188@work.bitmover.com> <1045243414.1353.28.camel@irongate.swansea.linux.org.uk> <20030214163611.GD3188@work.bitmover.com> <Pine.LNX.4.44.0302141916490.32518-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302141916490.32518-100000@serv>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 07:40:32PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Fri, 14 Feb 2003, Larry McVoy wrote:
> 
> > And what format lockin?  It's an open format, GNU CSSC reads and writes
> > it just fine, and we've made a point over the years of telling them each
> > time we change something so that they can continue to read/write our
> > files.  More FUD.
> 
> Are these changes/extensions documented somewhere or is a patch available?
> My version of cssc certainly has a few problems, without patching it's 
> very noisy.

The only change is to accept ^AHxxxxx as well as ^Ahxxxxx as the per file
checksum.  I'm almost positive that someone posted a patch to the kernel
which made CSSC like BK files.

If the BK files are compressed, you have to uncompress them first and you
can't use gunzip to do so, you have to use BK.  You could teach CSSC to
read our compressed files if you like, there is no secret to how we do 
that, the top part of the file containing the graph is uncompressed and
the rest is compressed, so you have to tickle the code into being able to
start uncompressing at an offset other than 0.

The only other difference I know of is that we support files without newlines
at the end of the file and CSSC doesn't (and I don't blame them, it is 
dramatically more difficult than you might think at first glance).
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
