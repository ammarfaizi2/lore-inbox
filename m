Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272122AbRI0JCn>; Thu, 27 Sep 2001 05:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272181AbRI0JCd>; Thu, 27 Sep 2001 05:02:33 -0400
Received: from chiara.elte.hu ([157.181.150.200]:15373 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S272122AbRI0JCW>;
	Thu, 27 Sep 2001 05:02:22 -0400
Date: Thu, 27 Sep 2001 11:00:24 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>, <webcam@smcc.demon.nl>,
        "Eloy A.Paris" <eloy.paris@usa.net>,
        <linux-usb-devel@lists.sourceforge.net>
Subject: RE: [PATCH -R] Re: 2.4.10 is toxic to my system when I use my US
In-Reply-To: <XFMail.010927083327.nemosoft@smcc.demon.nl>
Message-ID: <Pine.LNX.4.33.0109271057030.3716-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Nemosoft Unv. wrote:

> >           list_del (p);
> >           p = p->next;
> >           delete_desc (s, desc);

> Personally, I say the above piece of code is faulty. Refering to a
> pointer after you appearently deleted it, is just very bad programming
> practice.

yep. this is one reason why the 2.4.10 kernel clears the ->next and ->prev
pointers in list_del() - the above code will break immediately.

	Ingo

