Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269377AbUH0JIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269377AbUH0JIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269379AbUH0JIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:08:41 -0400
Received: from gate.firmix.at ([80.109.18.208]:7398 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S269235AbUH0JEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:04:35 -0400
Subject: Re: silent semantic changes with reiser4
From: Bernd Petrovitsch <bernd@firmix.at>
To: Christoph Hellwig <hch@lst.de>
Cc: Spam <spam@tnonline.net>, Wichert Akkerman <wichert@wiggy.net>,
       Christer Weinigel <christer@weinigel.se>, Andrew Morton <akpm@osdl.org>,
       jra@samba.org, torvalds@osdl.org, reiser@namesys.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
In-Reply-To: <20040827084910.GA21968@lst.de>
References: <20040825233739.GP10907@legion.cup.hp.com>
	 <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net>
	 <20040826024956.08b66b46.akpm@osdl.org>
	 <839984491.20040826122025@tnonline.net> <m3llg2m9o0.fsf@zoo.weinigel.se>
	 <1906433242.20040826133511@tnonline.net> <20040826113332.GL2612@wiggy.net>
	 <1211039639.20040826134354@tnonline.net>
	 <1093592467.18603.6.camel@tara.firmix.at>  <20040827084910.GA21968@lst.de>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1093597426.18604.86.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Fri, 27 Aug 2004 11:03:46 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 10:49 +0200, Christoph Hellwig wrote:

> On Fri, Aug 27, 2004 at 09:41:07AM +0200, Bernd Petrovitsch wrote:
> > > > UNIX doesn't have a copy systemcall, applications copy the data
> > > > manually.
> > > 
> > >   Oh, this is very unfortunate and should be a bigger issue to fix.
> > 
> > Then you have to rewrite POSIX und SuSv3.
> 
> They don't say 'you must now have a copy syscall'.  Having one that's
> actually used by system tools would be a great optimization for many
> network or distributed filesystems.

ACK. But actually spam apparently assumes that the kernel - userspace
interface is at the wrong abstraction level. And this is conceptually
bound IMHO to POSIX.
And it does not solve the problem, that the read() and write() sys-calls
will not vanish. Even if a copy() sys-call exists.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

