Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261219AbREOSh2>; Tue, 15 May 2001 14:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261221AbREOShI>; Tue, 15 May 2001 14:37:08 -0400
Received: from [206.14.214.140] ([206.14.214.140]:16645 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261219AbREOSg5>; Tue, 15 May 2001 14:36:57 -0400
Date: Tue, 15 May 2001 11:36:41 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Alexander Viro <viro@math.psu.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <20010515201821.B754@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.10.10105151130440.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The only problem with mmap(): You cannot know, if the page
> changed under you a**.
> 
> What would first mmap()ed page of the screen look like, if some
> accelerator wrote a line there? Invalidating all mmap()ed pages
> for each and every accelerator command would be evil. Forbidding
> reads of that page is evil, too.
> 
> I have the same problem with DSPs, which like to mmap() some of
> their memory into the application, but can alter this memory
> every instruction the execute.

I know about this problem for some time :-( Unfortunely most cards don't
have OpenGL or some similar api on chip. Of course you don't have to
invalid all the mappings. Only the ones the accelerator affected. This
plus proper serialization could over come this. 


