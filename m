Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSGBRxI>; Tue, 2 Jul 2002 13:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316843AbSGBRxH>; Tue, 2 Jul 2002 13:53:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59664 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316842AbSGBRxH>;
	Tue, 2 Jul 2002 13:53:07 -0400
Message-ID: <3D21EA60.D4545AAC@zip.com.au>
Date: Tue, 02 Jul 2002 11:01:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dax Kelson <dax@GuruLabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3Com 3c905C Tornado (newish 2.4.x) improper frame processing
References: <1025631796.8314.43.camel@porthos>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson wrote:
> 
> A frame with a destination address of FF:00:00:00:00:00 shouldn't be
> processed, unless the card has been told to listen to that multicast
> address.
> 
> Driver/Card information:
> -------------------
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 00:10.0: 3Com PCI 3c905C Tornado at 0xe000. Vers LK1.1.1600:10.0
> 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
> -------------------

There's a full implementation of hardware hashed filtering in
3com's GPL'ed 3c90x driver.  But nobody got around to pilfering
it.

-
