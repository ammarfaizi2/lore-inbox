Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130470AbRCDKmV>; Sun, 4 Mar 2001 05:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRCDKmL>; Sun, 4 Mar 2001 05:42:11 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:18134 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130470AbRCDKmE>; Sun, 4 Mar 2001 05:42:04 -0500
Message-ID: <3AA21C04.D651DB87@uow.edu.au>
Date: Sun, 04 Mar 2001 21:42:12 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
CC: linux-fbdev-devel@sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Brad Douglas <brad@neruo.com>
Subject: Re: [prepatches] removal of console_lock
In-Reply-To: <3AA1EF6C.A9C7613E@uow.edu.au> <3AA21866.62907063@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet wrote:
> 
> Andrew Morton wrote:
> 
> > This patch fixes it.  Interrupts are enabled across all console operations.
> >
> > It's still somewhat a work-in-progress.
> 
> The patch applies OK against 2.4.3-pre1
> At the end of make bzImage I got
> kerne/kernel.o(.text+0xcd00): undefined reference to 'in_interrupt'

Thanks.  Add a

#include <linux/interrupt.h>

to kernel/pm.c
