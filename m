Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262272AbTCHWkG>; Sat, 8 Mar 2003 17:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbTCHWkG>; Sat, 8 Mar 2003 17:40:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2740
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262272AbTCHWkC>; Sat, 8 Mar 2003 17:40:02 -0500
Subject: Re: [PATCH] register_blkdev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Joel Becker <Joel.Becker@oracle.com>, Greg KH <greg@kroah.com>,
       Andries.Brouwer@cwi.nl, akpm@digeo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303081431030.19716-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303081431030.19716-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047167794.26807.55.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 08 Mar 2003 23:56:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-08 at 22:36, Linus Torvalds wrote:
> I certainly agree that we'll need to open up the number space, but I 
> really do think that the way to _manage_ it is something like what Greg 
> pointed to - dynamic tols with "rules" on allocation, instead of the 
> stupid static manual assignment thing.

Greg's tools still have unsolved security holes in them. We still have
unsolved persistence of permissions and reuse problems. I think they are
soluble. The current insoluble dirty great security hole we have is
lack of vhangup for non tty devices (ie BSD revoke). Right now that
allows some quite nasty things to occur if you ever had console access.

> We're pretty close to it already. I thought some Linux vendors are already 
> starting to pick up on the hotplugging tools, simply because there are no 
> real alternatives.

For certain kinds of device yes.

> And once you do it that way, the static numbers are meaningless. And good 
> riddance.

Static naming/permissions management is current simply the best of
available evils for many things. With stuff like modem arrays on serial
ports its also neccessary to know what goes where. I'm all for moving to
setups when possible where things like SCSI volumes carry a volume name
and permission/acl data in the label


