Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263064AbSJGOTe>; Mon, 7 Oct 2002 10:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263065AbSJGOTe>; Mon, 7 Oct 2002 10:19:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57093 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263064AbSJGOTd>;
	Mon, 7 Oct 2002 10:19:33 -0400
Date: Mon, 7 Oct 2002 15:25:10 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: RFC: remove bcopy()
Message-ID: <20021007152510.K18545@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are very few places in the kernel which use bcopy() as of 2.5.40,
and every single one of them #defines it to memcpy() [some argue this
should be memmove().  i'm not terribly concerned].  There's also no
declaration of the bcopy() function in the kernel headers.  In light of
this, would anyone object to a patch removing the definitions of bcopy
from lib/string.c and arch/*/lib?

-- 
Revolutions do not require corporate support.
