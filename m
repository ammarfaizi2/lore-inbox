Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133109AbRDVBrh>; Sat, 21 Apr 2001 21:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133110AbRDVBr2>; Sat, 21 Apr 2001 21:47:28 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:6916 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S133109AbRDVBrM>;
	Sat, 21 Apr 2001 21:47:12 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104220147.f3M1l2v126874@saturn.cs.uml.edu>
Subject: Re: Request for comment -- a better attribution system
To: chromi@cyberspace.org (Jonathan Morton)
Date: Sat, 21 Apr 2001 21:47:02 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        babydr@baby-dragons.com (Mr. James W. Laferriere), esr@thyrsus.com,
        linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <l03130310b707dc53131a@[192.168.239.105]> from "Jonathan Morton" at Apr 22, 2001 02:00:02 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> 	Find . -name "*Some-Name*" -type f -print | xargs grep 'Some-Info'
> >> 	Hate answering with just one line of credible info , But .
> >
> >The above would grep every file. It takes 1 minute and 9.5 seconds.
> >So the distributed maintainer information does not scale well at all.
> 
> No it doesn't.  It allows you to search for files of a specific naming
> pattern and greps those.  So if you needed to know the maintainers of all
> the config.in files, you say:
> 
> find . -name "*onfig.in" -type f -print | xargs grep 'P: '

That was an easy problem, and try it to see all the bad matches!
This would be more normal:

find . -type f | xargs egrep -i8 '^[^A-Z]*[A-Z]: .*(net|ip|tcp|eth|ppp)'

That is not a nice and easy command for most people, and if it
isn't exactly right you just wasted over a minute.

