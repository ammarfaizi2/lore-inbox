Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317380AbSGOIVY>; Mon, 15 Jul 2002 04:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSGOIVX>; Mon, 15 Jul 2002 04:21:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9235 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317380AbSGOIVW>; Mon, 15 Jul 2002 04:21:22 -0400
Date: Mon, 15 Jul 2002 09:24:11 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
Message-ID: <20020715092411.A12082@flint.arm.linux.org.uk>
References: <agtlq6$iht$1@penguin.transmeta.com> <200207150656.g6F6uFx178288@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207150656.g6F6uFx178288@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Mon, Jul 15, 2002 at 02:56:14AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 02:56:14AM -0400, Albert D. Cahalan wrote:
> Unfortunately, the hack must remain for another 4 years or so.
> Maybe that's not so bad though. I prefer it over this:
> 
> #ifdef __386__
> #define HZ 100
> #endif
> #ifdef __IA64__
> #define HZ 1024
> #endif
> #ifdef __ARM__
> #define HZ 128  // if they settle on this

Ehh?  It's been 100 on the majority of ARM.  If it's different in libproc,
the libproc is broken.  One (broken) machine type decided it would be a
good idea to change it to 1000.  Since no one has paid any attention
to this machine for some time, it's support code will get dropped if
they don't fix it before 2.6.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

