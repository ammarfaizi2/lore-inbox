Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131362AbRDBWBK>; Mon, 2 Apr 2001 18:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRDBWBA>; Mon, 2 Apr 2001 18:01:00 -0400
Received: from hera.cwi.nl ([192.16.191.8]:35537 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131362AbRDBWAy>;
	Mon, 2 Apr 2001 18:00:54 -0400
Date: Mon, 2 Apr 2001 23:59:35 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200104022159.XAA52100.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: Larger dev_t
Cc: hpa@transmeta.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
   tytso@MIT.EDU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mount NFS device areas with NFSv2. Thats the standard workaround

Oh, sure. We survived with 16 bits and we'll survive with 32.
Nevertheless it is a bad sign that you have to start talking
about workarounds even before the new system has been implemented.

(And NFSv2 has its quirks as well.
Solaris will split the 32-bit number (the size given in a CREATE
request) into 14+18 when it is not a 16-bit value, while it will
split it into 8+8 if it is. FreeBSD will regard it as a 8+24 dev_t.
So, in general, different systems will parse the same dev_t in
different ways, and hence see different (major,minor) for the
same device.)

Andries
