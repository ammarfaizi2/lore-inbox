Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbQKPVoj>; Thu, 16 Nov 2000 16:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKPVo2>; Thu, 16 Nov 2000 16:44:28 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:1695 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S129069AbQKPVoN>;
	Thu, 16 Nov 2000 16:44:13 -0500
Message-Id: <4.3.2.7.2.20001116161327.00b2f810@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 16 Nov 2000 16:17:31 -0500
To: linux-kernel@vger.kernel.org
From: David Feuer <David_Feuer@brown.edu>
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <Pine.LNX.4.21.0011161934370.30811-100000@sisley.ri.silicom
 p.fr>
In-Reply-To: <Pine.GSO.4.21.0011161317120.13047-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:51 PM 11/16/2000 +0100, you wrote:
>Now I see your point : by "." or "foo/." you mean the directory itself,
>while "foo" or "foo/" refer to the link to the directory, and they are
>obviously different objects... at least since hard links on directories
>were introduced. Fine.

. and foo/. are also links, not directories... the directories themselves 
are filesystem internal objects, and not discussed by the standard.  I 
didn't know that linux supported hard links to directories... Isn't that 
just asking for trouble?


> > Besides, we clearly violated
> > all relevant standards - rmdir() and rename() are required to fail
> > if the last component of name happens to "." or "..".
>
>By standard, do you imply 'de facto' ? Or does any source clearly state
>this ?

It rarely hurts to violate even a written standard when it says something 
like this...  If it says something like this (which can only happen 
intentionally, afaict) should fail, but you can do something intelligent 
instead, you probably should.


--
This message has been brought to you by the letter alpha and the number pi.
Open Source: Think locally, act globally.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
