Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288159AbSAIG2k>; Wed, 9 Jan 2002 01:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288876AbSAIG2a>; Wed, 9 Jan 2002 01:28:30 -0500
Received: from pool-141-154-202-101.bos.east.verizon.net ([141.154.202.101]:48646
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S288159AbSAIG2V>; Wed, 9 Jan 2002 01:28:21 -0500
To: Doug Ledford <dledford@redhat.com>
Cc: willy tarreau <wtarreau@yahoo.fr>, Mario Mikocevic <mozgy@hinet.hr>,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio
In-Reply-To: <20020108163141.57751.qmail@web20507.mail.yahoo.com>
	<3C3B4F7F.8010901@redhat.com>
From: Nick Papadonis <nick@coelacanth.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Date: 09 Jan 2002 01:28:15 -0500
In-Reply-To: <3C3B4F7F.8010901@redhat.com> (Doug Ledford's message of "Tue, 08 Jan 2002 14:58:55 -0500")
Message-ID: <m3sn9g2g3k.fsf@localhost.localdomain>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford <dledford@redhat.com> writes:
> Someone posted one of the DMA Overrun on write error messages to me,
> and that allowed me to see that on the SiS hardware we are getting
> garbage in the upper 3 bits of the LVI register (presumably because we
> read garbage from the upper 3 bits of the CIV register).  So, I've put
> a 0.15 version of my driver on my site that now bounds our LVI and CIV
> reads so that we mask out any possible garbage.  And, since writing
> garbage to LVI could keep the hardware going in loops forever and
> other sorts of bad things, it might solve your problem.  Please give
> it a try and let me know how it works.
> 

0.15 works better then 0.13 for me.  I haven't had any problems yet.
