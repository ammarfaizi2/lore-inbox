Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289581AbSBKOI2>; Mon, 11 Feb 2002 09:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289657AbSBKOIK>; Mon, 11 Feb 2002 09:08:10 -0500
Received: from dns.logatique.fr ([213.41.101.1]:36859 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S289647AbSBKOHP>; Mon, 11 Feb 2002 09:07:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <tcaprice@logatique.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: RFC: scheduler, and per-arch switch_to
Date: Mon, 11 Feb 2002 15:06:31 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C67C740.43AAD437@mandrakesoft.com>
In-Reply-To: <3C67C740.43AAD437@mandrakesoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020211140438.B81F923CBB@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I agree. While porting to zeta (see previous mail), i've had a look at some 
different arch/ implementation of switch_to(), and i have not been able to 
understand why the third arg was given. 
Anyway, I don't use it, and I'm happy with this new interface.

Thomas



On Monday 11 February 2002 14:29, Jeff Garzik wrote:
> Do we really care about the third arg to the switch_to() macro?
>
> IMHO it would be nice to define the architecture context switch
> interface like
>
>   void switch_to(struct thread_info *from, struct thread_info *to);
>
> because we don't really seem to do much with the third arg, AFAICS.
