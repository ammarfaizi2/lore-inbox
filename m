Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135396AbRDVWdL>; Sun, 22 Apr 2001 18:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136305AbRDVWdB>; Sun, 22 Apr 2001 18:33:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4879 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S135399AbRDVWcw>;
	Sun, 22 Apr 2001 18:32:52 -0400
Date: Sun, 22 Apr 2001 23:32:47 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Cc: Oliver.Neukum@lrz.uni-muenchen.de
Subject: Re: question on atomic_t
Message-ID: <20010422233247.A18464@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> can I assume that a member of a structure of type atomic_t is 0 after
> using memset to zero on the structure ?

You must not do this.  use atomic_init instead.  on parisc, the locked value
of a spinlock is 0, so no more updates to that atomic value would ever work.

-- 
Revolutions do not require corporate support.
