Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267087AbTGKWaa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 18:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267089AbTGKWaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 18:30:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:7141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267087AbTGKWaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 18:30:25 -0400
Date: Fri, 11 Jul 2003 15:44:58 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SECURITY - data leakage due to incorrect strncpy implementation
In-Reply-To: <1057959932.20637.51.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307111544020.4337-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jul 2003, Alan Cox wrote:
> 
> Lots of kernel drivers rely on the libc definition of strncpy. 

But that's ok. We _do_ do the padding. I hated it when I wrote it, but as 
far as I know, the kernel strncpy() has done padding pretty much since day 
one.

Yes, strlcpy() conversion users need to be careful, but I think we mostly 
_were_ careful. Knock wood.

		Linus

