Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbQJ3Qox>; Mon, 30 Oct 2000 11:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129045AbQJ3Qon>; Mon, 30 Oct 2000 11:44:43 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46866 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129043AbQJ3Qof>;
	Mon, 30 Oct 2000 11:44:35 -0500
Message-ID: <39FDA548.7CDDF63A@mandrakesoft.com>
Date: Mon, 30 Oct 2000 11:43:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Andrew Morton <andrewm@uow.edu.au>, "Stephen E. Clark" <sclark46@gte.net>,
        lk <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: RTNL assert
In-Reply-To: <Pine.LNX.4.21.0010301505550.14004-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> On Sat, 28 Oct 2000, Andrew Morton wrote:
> 
> > The rtnetlink lock needs to be taken around
> > register_netdevice().  There should be a function
> > which does these three common steps, but there isn't.
> 
> I thought the only difference between register_netdev() and
> register_netdevice() was that one took the rtnl_lock and the other didn't?

And, register_netdev allocates a name for you if necessary...

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
