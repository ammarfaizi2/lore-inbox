Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317381AbSGZI4P>; Fri, 26 Jul 2002 04:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317389AbSGZI4P>; Fri, 26 Jul 2002 04:56:15 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:13812 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317381AbSGZI4P>; Fri, 26 Jul 2002 04:56:15 -0400
Subject: Re: [PATCH] IDE 104
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D40F8F9.1050507@evision.ag>
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
	 <3D40F8F9.1050507@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Jul 2002 11:13:31 +0100
Message-Id: <1027678411.13428.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-26 at 08:23, Marcin Dalecki wrote:
> - Make the bit-sliced data types in hdreg.h use the bit-slice data types
>    instead of the generic ones. This makes clear that those are supposed
>    to be register masks.

Because its an external API it needs to remain constant. Swapping
uchar/uint looks fine and the structure is off the drive anyway. However
they should be __u16 __u8 __u32 so that C libraries and apps can still
use the header (its __u16 because 'u16' cannot be exposed to user space
directly or via libc)

Alan

