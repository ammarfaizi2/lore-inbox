Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267037AbRGJSO4>; Tue, 10 Jul 2001 14:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbRGJSOq>; Tue, 10 Jul 2001 14:14:46 -0400
Received: from patan.Sun.COM ([192.18.98.43]:2240 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S267038AbRGJSOc>;
	Tue, 10 Jul 2001 14:14:32 -0400
Message-ID: <3B4B47C5.F176C3C2@sun.com>
Date: Tue, 10 Jul 2001 11:21:57 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>,
        groudier@club-internet.fr, alan@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  sym53c8xx timer rework
In-Reply-To: <3B4ACF6B.5F194E54@stud.uni-saarland.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Studierende der Universitaet des Saarlandes wrote:

> > +       NCR_LOCK_NCB(np, flags);
> > +       del_timer(&np->timer);
> > +       NCR_UNLOCK_NCB(np, flags);
> 
> I'm only reading the diff, but this change looks wrong.
> The simplest solution is del_timer_sync() instead of
> LOCK;del_timer;UNLOCK.

I didn't even realize there was a del_timer_sync().  That does what is
needed.  3 lines become 1, I guess.

Thanks, CC:ed to Gerard and crew.

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
