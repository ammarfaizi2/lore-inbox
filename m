Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129770AbQKFU2o>; Mon, 6 Nov 2000 15:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129646AbQKFU2e>; Mon, 6 Nov 2000 15:28:34 -0500
Received: from smtp1.mail.yahoo.com ([128.11.69.60]:26889 "HELO
	smtp1.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129770AbQKFU22>; Mon, 6 Nov 2000 15:28:28 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A070675.49B72B99@yahoo.com>
Date: Mon, 06 Nov 2000 14:28:53 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18pre18 i486)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, tytso@mit.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <E13rj9s-0003c4-00@the-village.bc.nu> <3A03302C.C2A87573@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Alan Cox wrote:
> > >      * Check all devices use resources properly (Everyone now has to use
> > >        request_region and check the return since we no longer single
> > >        thread driver inits in all module cases. Also memory regions are
> > >        now requestable and a lot of old drivers dont know this yet. --
> > >        Alan Cox)
> >
> > Folks have done most of the common drivers. So its not really a show stopper
> > now just a 'clean up'
> 
> s/check_region/request_region/ is moving along, but there is still a
> ways to go.  I agree with "folks have done most of the common drivers"
> 
> I have seen very few additions of request_mem_region, though.

Something which I forgot to add when mentioning my ioremap patch is
that you can pretty much forget about adding request_mem_region() to the
same drivers since both changes are in the same spot of code and doing
one without doing the other is kind of silly. (i.e. the patches I have
for 8390 based drivers do both at once).

Although simply having a dev->vmem [or dev->base] added to struct
netdevice in 2.4.0, as was discussed many months ago(*) might go a long
way in allowing driver back-compatibility from 2.5.x into 2.4.x - probably
worthwhile.

(*) Search <Pine.LNX.4.10.9912281026030.1294-100000@penguin.transmeta.com>
    in any linux-net mailing list archive of Dec 1999.

Paul.



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
