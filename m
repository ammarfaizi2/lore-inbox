Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130889AbRAPO4g>; Tue, 16 Jan 2001 09:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131794AbRAPO41>; Tue, 16 Jan 2001 09:56:27 -0500
Received: from penguin.roanoke.edu ([199.111.154.8]:29714 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S130889AbRAPO4M>; Tue, 16 Jan 2001 09:56:12 -0500
Message-ID: <3A646322.B76A1661@linuxjedi.org>
Date: Tue, 16 Jan 2001 10:05:06 -0500
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Felix von Leitner <leitner@convergence.de>, linux-kernel@vger.kernel.org,
        mingo@elte.hu
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <20010116114018.A28720@convergence.de> <Pine.LNX.4.30.0101161338270.947-100000@elte.hu> <20010116134737.A29366@convergence.de> <20010116144849.B19949@pcep-jamie.cern.ch> <20010116152023.A32180@convergence.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:
> >   close (0);
> >   close (1);
> >   close (2);
> >   open ("/dev/console", O_RDWR);
> >   dup ();
> >   dup ();
> 
> So it's not actually part of POSIX, it's just to get around fixing
> legacy code? ;-)

This makes me wonder...

If the kernel only kept a queue of the three smallest unused fd's, and
when the queue emptied handed out whatever it liked, how many things
would break?  I suspect this would cover a lot of bases...

<dons flameproof underwear>

regards,
	David

-- 
David L. Parsley
Network Administrator
Roanoke College
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
