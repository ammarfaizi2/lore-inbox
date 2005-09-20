Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbVITRDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbVITRDK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbVITRDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:03:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932718AbVITRDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:03:08 -0400
Date: Tue, 20 Sep 2005 10:02:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sean <seanlkml@sympatico.ca>
cc: Jan Dittmer <jdittmer@ppp0.net>, Alexander Nyberg <alexn@telia.com>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: Arrr! Linux v2.6.14-rc2
In-Reply-To: <BAYC1-PASMTP0390B5ABE91EDE56C81EDBAE950@cez.ice>
Message-ID: <Pine.LNX.4.58.0509200959220.2553@g5.osdl.org>
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>         
 <200509201005.49294.gene.heskett@verizon.net>         
 <20050920141008.GA493@flint.arm.linux.org.uk>         
 <200509201025.36998.gene.heskett@verizon.net>         
 <56402.10.10.10.28.1127229646.squirrel@linux1>         
 <20050920153231.GA2958@localhost.localdomain>      
 <BAYC1-PASMTP030BBDF3F9B2552DA9CF26AE950@cez.ice>       <43303650.5030202@sfhq.hn.org>
    <BAYC1-PASMTP033EBAB483DBE4397549B2AE950@cez.ice>    <43303C85.1020301@ppp0.net>
 <BAYC1-PASMTP0390B5ABE91EDE56C81EDBAE950@cez.ice>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Sep 2005, Sean wrote:
> 
> That's a good point.  Guess it would be useful if the HEAD commit was
> documented along with each -gitX release.

It is. Just get the "id" file that is associated with a snapshot, and it 
gives the git commit ID for that state.

So for example, the 2.6.14-rc1-git3 snapshot is associated with the ID 
file patch-2.6.14-rc1-git3.id, which contains 

	v2.6/snapshots(0)$ cat patch-2.6.14-rc1-git3.id
	065d9cac98a5406ecd5a1368f8fd38f55739dee9

so once you know that something broke between rc1-git3 and rc1-git4, you 
can now do

	git bisect start
	git bisect good 065d9cac98a5406ecd5a1368f8fd38f55739dee9
	git bisect bad bc5e8fdfc622b03acf5ac974a1b8b26da6511c99

and off you go..

		Linus
