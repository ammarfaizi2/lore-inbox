Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272230AbTGYRmi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272232AbTGYRma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:42:30 -0400
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:25313 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S272230AbTGYRkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:40:23 -0400
Date: Fri, 25 Jul 2003 13:55:14 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: Net device byte statistics
In-reply-to: <20030725102043.724f4a3b.rddunlap@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, ecki-lkm@lina.inka.de,
       linux-kernel@vger.kernel.org
Message-id: <200307251355.22161.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.2
References: <E19fqMF-0007me-00@calista.inka.de>
 <200307251223.51849.jeffpc@optonline.net>
 <20030725102043.724f4a3b.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 25 July 2003 13:20, Randy.Dunlap wrote:
> Yes, a common solution for this is to use some SNMP agent that does
> 64-bit counter accumulation.

Interesting...I haven't thought of SNMP.

> IETF expects that some high-speed interfaces will have 64-bit
> counters.  From RFC 2233 (Interfaces Group MIB using SMIv2):
>
> <quote>
> For interfaces that operate at 20,000,000 (20 million) bits per
> second or less, 32-bit byte and packet counters MUST be used.
> For interfaces that operate faster than 20,000,000 bits/second,
> and slower than 650,000,000 bits/second, 32-bit packet counters
> MUST be used and 64-bit octet counters MUST be used. For
> interfaces that operate at 650,000,000 bits/second or faster,
> 64-bit packet counters AND 64-bit octet counters MUST be used.
> </quote>

It is just easier to have everything 64-bits.

> However, this is a MIB spec.  It does not require a Linux
> (/proc) interface to support 64-bit counters.

Agreed, however if we are going to change some counters, we should do it for 
all of them. (Btw, /proc is not the only point where users can get stats.... 
there is also /sys and something else...I can't remember now...)

Jeff.

- -- 
Research, n.:
  Consider Columbus:
    He didn't know where he was going.
    When he got there he didn't know where he was.
    When he got back he didn't know where he had been.
    And he did it all on someone else's money.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IW8GwFP0+seVj/4RAhf3AKDAtCkm8UdL4T1ZQzqttEG7XyVW9ACeIT6m
RKO8c2UnpSuJwyvwHd5PS8c=
=4vls
-----END PGP SIGNATURE-----

