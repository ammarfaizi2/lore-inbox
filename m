Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129334AbRAZCLp>; Thu, 25 Jan 2001 21:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129398AbRAZCLg>; Thu, 25 Jan 2001 21:11:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4749 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129334AbRAZCLT>;
	Thu, 25 Jan 2001 21:11:19 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.56461.296642.488513@pizda.ninka.net>
Date: Thu, 25 Jan 2001 18:10:21 -0800 (PST)
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <3A70D7B2.F8C5F67C@transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
	<94qcvm$9qp$1@cesium.transmeta.com>
	<14960.54069.369317.517425@pizda.ninka.net>
	<3A70D524.11362EFB@transmeta.com>
	<14960.54852.630103.360704@pizda.ninka.net>
	<3A70D7B2.F8C5F67C@transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


H. Peter Anvin writes:
 > > RFC793, where is lists the unused flag bits as "reserved".
 > > That is pretty clear to me.  It just has to say that
 > > they are reserved, and that is what it does.
 > > 
 > 
 > Is the definition of "reserved" defined anywhere?  In a lot of specs,
 > "reserved" means MBZ.
 > 
 > Note, that I'm not arguing with you.  I'm trying to pick this apart.

It says "reserved for future use, must be zero".

I think the descrepency (and thus what the firewalls are doing) comes
from the ambiguous "must be zero".  I cannot fathom the RFC authors
meaning this to be anything other than "must be set to zero by current
implementations" or else what is the purpose of the "reserved for
future use part" right?

Honestly, is there anyone here who can tell me honestly that when they
see the words "reserved" in the description of a bit field description
(in a hardware programmers manual of some device, for example) that
they think it's ok the read the value and interpret it in any way?

To me it's always meant "we want to do cool things in the future,
things we haven't thought of now, so don't interpret these bits so we
can do that and you will still work".

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
