Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270520AbRHNI3U>; Tue, 14 Aug 2001 04:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270519AbRHNI3K>; Tue, 14 Aug 2001 04:29:10 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:41482 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S270521AbRHNI3C>; Tue, 14 Aug 2001 04:29:02 -0400
Message-ID: <3B78E10A.E8772B79@idb.hist.no>
Date: Tue, 14 Aug 2001 10:27:54 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-pre8 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VM nuisance
In-Reply-To: <Pine.LNX.4.33.0108130716321.20672-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
[...]
> so why not just use the most simple OOM around:  shoot the first app which
> can't get its page.  app writers won't like it, and users won't like it
> until the app writers fix their bugs, but then nobody likes the current
> situation, so what's the difference?

It used to be like that.  Unfortunately, the first app unable to
get its page might very well be init, and then the entire system goes
down in flames.  You might as well kill the kernel at that point.

Fix that, and people start complaining that the X server goes, taking
all X apps with it when killing one would suffice.  Fix that,
and you almost have today's OOM killer.  

The real solution is to have enough memory for the task at hand. 
Failing
that, get so much swap space that people will be happy when the OOM
killer kicks in and limits the trashing.

Helge Hafting
