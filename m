Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAZOMU>; Fri, 26 Jan 2001 09:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRAZOMK>; Fri, 26 Jan 2001 09:12:10 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:45576 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S129561AbRAZOMD>; Fri, 26 Jan 2001 09:12:03 -0500
To: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
	<94qcvm$9qp$1@cesium.transmeta.com>
	<14960.54069.369317.517425@pizda.ninka.net>
	<3A70D524.11362EFB@transmeta.com>
	<14960.54852.630103.360704@pizda.ninka.net>
	<3A70D7B2.F8C5F67C@transmeta.com>
	<14960.56461.296642.488513@pizda.ninka.net>
	<20010125230653.A1850@foozle.turbogeek.org>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 26 Jan 2001 15:04:36 +0100
In-Reply-To: <20010125230653.A1850@foozle.turbogeek.org>
Message-ID: <tgsnm64dfv.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeremy M. Dolan" <jmd@foozle.turbogeek.org> writes:

> RFC1812              Requirements for IP Version 4 Routers 

RFC 1812 mandates routing of IP packets with reserved flags, but not
for TCP packets.

> RFC2979              Behavior of and Requirements for Internet Firewalls 
> 
> The last one seems it would have the most potential to clear up this
> mess, unfortunatly it's only an informational RFC, and at a quick
> glance, doesn't look like it addresses this issue. 

In fact, it does, but not in the way you want: ;-)

|   When a firewall acts a protocol end point it may
|
|    (1)   implement a "safe" subset of the protocol,
|
|    (2)   perform extensive protocol validity checks,

|   Good security may occasionally result in interoperability failures
|   between components.  This is understood.  However, this doesn't mean
|   that gratuitous interoperability failures caused by security
|   components are acceptable.

It is completely acceptable to deploy a firewall which drops packets
in which reserved flags are not zero.  Obviously, the implementer
doesn't know the effect of this flag (because they aren't defined
yet), so he's facing the choice whether to create a system which is
safe or a system which maximizes interoperability at the cost of
potential risks.  IMHO, the first choice is much more appropriate than
the second one.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
