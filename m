Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbTAVQTM>; Wed, 22 Jan 2003 11:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTAVQTM>; Wed, 22 Jan 2003 11:19:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11478 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261854AbTAVQTL>;
	Wed, 22 Jan 2003 11:19:11 -0500
Message-Id: <200301221628.h0MGSDl29588@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, smurf@osdl.org
Subject: Re: test suite? 
In-Reply-To: Message from "Robert P. J. Day" <rpjday@mindspring.com> 
   of "Wed, 22 Jan 2003 08:44:05 EST." <Pine.LNX.4.44.0301220840530.2622-100000@dell> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Jan 2003 08:28:13 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>   i've noticed references to "test suites" for kernels, but
> is there any one-step convenient way to select every possible
> option for test-compiling a new kernel, just to see if it builds?
> perhaps an "everything" option?
> 
>   and, related to that, should such a kernel theoretically
> work?  as in, are there any options that would be mutually
> exclusive that would cause such a build to fail?
> 
> still thinking about reorganizing the overall option structure,
> rday

The OSDL's patch lifecycle manager (http://www.osdl.org/cgi-bin/plm ) 
does something like this. It does a series of builds include a few that 
select most every option. So you could toss the patch into PLM and look at
the results of those test compiles.  In particular, the 'Desktop' config
turns on a ton of stuff ( and almost always fails ;)
We also do a 'regress' build, where we do 'make defconfig' and 
'make allmodconfig' and count the errors.

I don't think we have any more detailed docs, but the test report does include
the .config files we run.
cliffw

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


