Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268446AbRGZRKL>; Thu, 26 Jul 2001 13:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268371AbRGZRKB>; Thu, 26 Jul 2001 13:10:01 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:20490 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S268358AbRGZRJt>;
	Thu, 26 Jul 2001 13:09:49 -0400
From: tpepper@vato.org
Date: Thu, 26 Jul 2001 10:09:55 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Validating Pointers
Message-ID: <20010726100955.B18938@cb.vato.org>
In-Reply-To: <no.id> <E15PnRQ-0003yo-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E15PnRQ-0003yo-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jul 26, 2001 at 04:52:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu 26 Jul at 16:52:48 +0100 alan@lxorguk.ukuu.org.uk done said:
> access_ok may do minimal checks, or no checking at all. The only point at
> which you can validate a user point is when you use copy*user and
> get/put_user to access the data.

Should the i386 access_ok() fail when checking a copy to/from userspace
from/to a static in a driver module?  The __copy_to|from_user work fine
and copy_to|from_user fail, but I guess that doesn't mean access_ok()
is the culprit.  I don't know intel assembly and the platforms for
which I do get the assembly don't do much in access_ok() so there's no
comparing...but I'd have thought they'd be more concerned with the user
address location than the kernel one.

t.
