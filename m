Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262575AbRE3CST>; Tue, 29 May 2001 22:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbRE3CSJ>; Tue, 29 May 2001 22:18:09 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7918 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262575AbRE3CR6>;
	Tue, 29 May 2001 22:17:58 -0400
Message-ID: <3B14584B.25A01DB2@mandrakesoft.com>
Date: Tue, 29 May 2001 22:17:47 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jt@hpl.hp.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #9
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl> <20010529180420.A14639@bougret.hpl.hp.com> <3B14493E.63F861E7@mandrakesoft.com> <20010529182506.A14727@bougret.hpl.hp.com> <3B145127.5B173DFF@mandrakesoft.com> <20010529191338.A14867@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
>         Apart from this stupid flame that I'm making, I've got my
> Intel/Symbol card to work properly with the Orinoco driver. This mean
> that we are not far away to have the 4 main flavor of 802.11b working
> in 2.4.X (i.e. Lucent/Symbol/PrismII/Aironet).
>         See :
> http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Orinoco.html#patches
> 
>         Just to make sure we end on a positive note ;-) Now, if I
> could get the card of Alan to work...

Cool!  Though I do have a comment on this too.  :)

Are you sure priv->hw_ready is not racy?  You should probably use an
atomic operation like test_bit and set_bit.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
