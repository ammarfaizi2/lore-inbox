Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277330AbRJ3SRq>; Tue, 30 Oct 2001 13:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277363AbRJ3SRi>; Tue, 30 Oct 2001 13:17:38 -0500
Received: from freeside.toyota.com ([63.87.74.7]:12306 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S277330AbRJ3SR1>;
	Tue, 30 Oct 2001 13:17:27 -0500
Message-ID: <3BDEEE97.102DB553@lexus.com>
Date: Tue, 30 Oct 2001 10:17:15 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
In-Reply-To: <3BDDBC90.7E16E492@lexus.com> <20011029151036.F20280@mikef-linux.matchmail.com> <3BDDE422.938C1D95@lexus.com> <3BDE69A9.A3DE2070@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:

> J Sloan wrote:
>
> > Say, if the uptime field were unsigned it could
> > reach 995 days uptime before wraparound -
>
> Actually 497 days is from the max jiffies in an unsigned int.  Up time
> converts this to seconds... (HZ = 100) jiffies units are 1/HZ.

]Yes, I see now you are right -

Once I bothered to do the arithmetic,
I see it's already being treated as an
unsigned long, so just changing the
type in the struct won't buy us anything....

So much for quick fixes - I wonder what
FreeBSD does here...

cu

jjs

