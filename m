Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130194AbRBBWN6>; Fri, 2 Feb 2001 17:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130293AbRBBWNs>; Fri, 2 Feb 2001 17:13:48 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:39392 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130194AbRBBWNb>; Fri, 2 Feb 2001 17:13:31 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200102022213.f12MDCR27812@devserv.devel.redhat.com>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 2 Feb 2001 17:13:12 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), mason@suse.com (Chris Mason),
        kas@informatics.muni.cz (Jan Kasprzak), linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com,
        yura@yura.polnet.botik.ru (Yury Yu. Rupasov)
In-Reply-To: <3A7B269F.A028388C@namesys.com> from "Hans Reiser" at Feb 03, 2001 12:29:03 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> my convenience matters as much as that of the users.  I don't want to use
> #ifdefs, I want it to die explosively and verbosely informatively.  make isn't
> the most natural language for that, but I am sure Yura can find a way.

Run a small shell check and let it fail if the shell stuff errors.

The fragment you want is

if [ -e /bin/rpm ]; then
        X=`rpm -q gcc`
        if [ "$X" = "gcc-2.96-54" ]; then
                echo "*** GCC 2.96-54 will miscompile Reiserfs. Please update your compiler"
                echo "See http://www.redhat.com/support/errata/RHBA-2000-132.html"
                exit 255
        fi
fi


> Please delay shipping the 3.0 CVS branch on RedHat for a while.:-)  Sorry, I
> couldn't resist.

Grin. gcc 3.0 is going to be just as much fun Im sure, but finally should give
everyone a stable C and more importantly C++ base including the LSB standards.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
