Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289056AbSA3OlY>; Wed, 30 Jan 2002 09:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289148AbSA3OlP>; Wed, 30 Jan 2002 09:41:15 -0500
Received: from e23.nc.us.ibm.com ([32.97.136.229]:9892 "EHLO e23.esmtp.ibm.com")
	by vger.kernel.org with ESMTP id <S289056AbSA3OlE>;
	Wed, 30 Jan 2002 09:41:04 -0500
Date: Wed, 30 Jan 2002 20:13:04 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>, ak@suse.de, viro@math.psu.edu,
        jgmyers@netscape.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Writeup on AIO design (uploaded)
Message-ID: <20020130201304.A1859@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <20020129205620.A1886@in.ibm.com> <20020129225600.A10775@redhat.com> <20020130143215.B1378@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130143215.B1378@in.ibm.com>; from suparna@in.ibm.com on Wed, Jan 30, 2002 at 02:32:15PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have just uploaded the aio design notes to:
 http://lse.sourcefourge.net/io/aionotes.txt

Thanks to all those who helped with inputs and reviews of the interim 
drafts.

The writeup attempts to bring out some of the interesting design issues 
and discuss the solutions to those issues and the approach taken in 
Ben's design, and touches on the ideas for addressing some of the pending 
issues, todo items and potential enhancements. It also looks at some of
these aspects in the context of other implementations that exist or have 
been attempted on Linux (SGI kaio, Univ of Winsconsin-Madison's BAIO, 
Andi Kleen's early prototype), and the AIO related interfaces available 
on other OS's (POSIX aio, NT IOCPs, BSD kqueues), and also the DAFS api 
specifications. 

This was written with the intention of triggering discussions (though
this writeup wouldn't have been possible without all the discusions we've
already had :)). 

So please do share your insights, perspectives and comments. 

All the more so, if you already have a good understanding the aio 
design ! 

For those who are new to aio:
The focus here is only the in-kernel aio design, so you won't find much 
about actually using aio (Dan Kegel's page might be a better
place to start on that). There should, however, be some insights,
and pointers to the in-kernel primitives introduced as part of aio,
say, if you intend to implement your own async state machine (for some 
reason !). However, the writeup does not get into low level details and 
is not intended to be a substitute for looking at the code :). 
It should help you follow the code more easily though (I hope).

Regards
Suparna

