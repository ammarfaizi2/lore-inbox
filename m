Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbUAaCfY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 21:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264598AbUAaCfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 21:35:24 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:9435 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264583AbUAaCfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 21:35:16 -0500
Message-ID: <401B1463.3AEAF369@comcast.net>
Date: Fri, 30 Jan 2004 18:35:15 -0800
From: "Donald H. Gudehus" <gpage11@comcast.net>
Reply-To: gudehus@mindspring.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux/IA-64 byte order
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I write visualisation software for astronomy. This software is used
>all over the world, and often has to deal with very large
>datasets. It's not uncommon to "load" a dataset (a cube) but only view
>a small portion of it (a single plane (channel) of the cube). On
>big-endian machines I can avoid loading data and instead use memory
>mapping, because all the portable binary data formats are big-endian
>(FITS, Miriad and my own).

The SAD (Standard Astronomical Data) format is little-endian and was, in
fact, developed in your home country at Mt. Stromlo and Sliding Springs
Observatory.

>In the astronomy community, big-endian machines dominate (despite the
>growth of Linux/x86), and will always be favoured because the most
>important data format (FITS) is big-endian. When we tender for a new
>supercomputer, it is a requirement that it be big-endian.
>BTW: FITS has become a NIST standard and is widely used outside the
>astronomy community.


Here in the US, FITS can be big-endian or little-endian depending on
whether the keyword BYTEORDR equals BIG_ENDIAN or LITTLE_ENDIAN. 
Unfortunately this keyword is not always used because the byte order was
never specified in the original FITS description.  This naturally has
led to some confusion, with some facilities adopting big endian, some
adopting little endian, and some simply using the native format of the
machine.

Conceptually, it is more natural to have bits and bytes increase in
significance as system memory location (word address) increases.  This
is of course completely independent of graphical representations where
bit significance increases to the left, byte significance to the left or
right, and word significance to the left or right (four possible cases).

Donald Gudehus
