Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRDKFtn>; Wed, 11 Apr 2001 01:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131307AbRDKFtd>; Wed, 11 Apr 2001 01:49:33 -0400
Received: from relay03.valueweb.net ([216.219.253.237]:11792 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S131289AbRDKFtS>; Wed, 11 Apr 2001 01:49:18 -0400
Message-ID: <3AD3F1C0.62363C4A@opersys.com>
Date: Wed, 11 Apr 2001 01:55:12 -0400
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Mark Salisbury <mbs@mc.com>
CC: Martin Mares <mj@suse.cz>, Andi Kleen <ak@suse.de>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
In-Reply-To: <200104091830.NAA03017@ccure.karaya.com> <20010410075109.A9549@gruyere.muc.suse.de> <20010410113309.A16825@atrey.karlin.mff.cuni.cz> <0104100818281A.01893@pc-eng24.mc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Salisbury wrote:
> 
> It would probably be a good compile config option to allow fine or coarse
> process time accounting, that leaves the choice to the person setting up the
> system to make the choice based on their needs.
> 

I suggested this a while ago during a discussion about performance
measurement. This would be fairly easy to implement using the patch
provided with the Linux Trace Toolkit since all entry points and
exit points are known (and it already is available in post-mortem
analysis). Implementing the measurement code within the kernel should
be fairly easy to implement and it would be provided as part of the
compile option. All in all, given the measurements I made, I'd place
the overhead at around 1% for the computations. (The overhead is very
likely to be negligeable when eventual fixes are taken into account.)

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
