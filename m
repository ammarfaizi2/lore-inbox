Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129088AbQKFNyN>; Mon, 6 Nov 2000 08:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129054AbQKFNyD>; Mon, 6 Nov 2000 08:54:03 -0500
Received: from lilac.csi.cam.ac.uk ([131.111.8.44]:1764 "EHLO
	lilac.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129034AbQKFNxw>; Mon, 6 Nov 2000 08:53:52 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
Date: Mon, 6 Nov 2000 13:31:23 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Morton <andrewm@uow.edu.au>, Oliver Xymoron <oxymoron@waste.org>,
        barryn@pobox.com, linux-kernel@vger.kernel.org,
        jamal <hadi@cyberus.ca>
In-Reply-To: <3A068C00.272BD5D2@uow.edu.au> <E13sk36-00066o-00@the-village.bc.nu> <20001106121153.A14104@gruyere.muc.suse.de>
In-Reply-To: <20001106121153.A14104@gruyere.muc.suse.de>
MIME-Version: 1.0
Message-Id: <00110613333600.01541@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, Andi Kleen wrote:
> On Mon, Nov 06, 2000 at 11:02:47AM +0000, Alan Cox wrote:
> > >        with the TCP ECN_ECHO and CWR flags set, to indicate
> > >        ECN-capability, then the sender should send its second
> > >        SYN packet without these flags set. This is because
> > 
> > Now that is nice. The end user perceived effect is that folks with faulty 
> > firewalls have horrible slow web sites with a 3 or 4 second wait for each
> > page. The perfect incentive. If only someone could do the same to path mtu
> > discovery incompetents.
> 
> And it penalizes good guys.
> If the host cannot answer to the first SYN for some legitimate reason 
> then it'll never be able to use ECN. 

It could be a good idea to retry as normal with ECN set; iff that fails
(so the user would normally see an error connecting) try again with
ECN clear. This way, ECN-capable hosts will only see non-ECN
connections under circumstances where the connection would
otherwise have failed completely.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
