Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbTIIAsj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbTIIAsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:48:39 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:12294 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263855AbTIIAsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:48:35 -0400
Message-ID: <3F5D2336.A1AF2EBF@SteelEye.com>
Date: Mon, 08 Sep 2003 20:47:50 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>,
       "Sven =?iso-8859-1?Q?K=F6hler?=" <skoehler@upb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [NBD] patch and documentation
References: <3F5CB554.5040507@upb.de> <20030908193838.GA435@elf.ucw.cz> <3F5CE0E5.A5A08A91@SteelEye.com> <3F5CE3E6.8070201@upb.de> <3F5CF045.DDDE475C@SteelEye.com> <3F5CFF0B.6080609@upb.de> <20030908222111.GG429@elf.ucw.cz> <3F5D0186.4030001@upb.de> <20030908232824.GH429@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > >>Another idea would be to be abled to specify the max_sectors while
> > >>connecting an NBD. That would add an optional paramter to the nbd-client
> > >>command line. (like it is possible for the blocksize)
> > >
> > >I do not see why it should be configurable...
> >
> > We may regret to use a certain value, although i agree that 1MB should
> > be sufficient for the future.
> 
> I believe that 1MB is good, and good enough for close future. If that
> ever proves to be problem, we can add handshake at that point. But I
> do not believe it will be neccessary.

But, who ever said the buffer in the nbd-server had to be statically
allocated? I have a version of nbd-server that is modified to handle any
size request that the client side throws at it -- if the buffer is not
large enough, it simply reallocates it.

--
Paul
