Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSILOfK>; Thu, 12 Sep 2002 10:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSILOfJ>; Thu, 12 Sep 2002 10:35:09 -0400
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:16648 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S315942AbSILOfG>; Thu, 12 Sep 2002 10:35:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Johan Brodin <d98jobro@dtek.chalmers.se>, linux-kernel@vger.kernel.org
Subject: Re: Init - how does it work?
Date: Thu, 12 Sep 2002 09:39:45 -0700
User-Agent: KMail/1.4.3
References: <Pine.GSO.4.10.10209121620340.13583-100000@licia.dtek.chalmers.se>
In-Reply-To: <Pine.GSO.4.10.10209121620340.13583-100000@licia.dtek.chalmers.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209120939.45643.nleroy@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2002 07:27, Johan Brodin wrote:
> Hi!
>
> I am new to this list, so I will take one second to present myself.
> My name is Johan and I am a 23-year old student at Chalmers university of
> technology in Sweden. The reason for joining this list is that I am
> currently doing my Master Thesis Project in Computer Science and
> Engineering. My thesis is namned "Design of dependable distributed
> UNIX-based systems" and one issue that I am looking into is process
> supervision.
>
> I tried to configure init to start and respawn processes and this worked
> great, no problems at all, but what really would make me happy is if
> someone of all you subscribers to this list could explain how this feature
> (respawn) works. How is init told that it must respawn the process? and
> such things! If someone could find the time to help me out, I would be
> very grateful.

Well, I'd reccomend reading the sources...

But, the short answer is SIGCHLD.  A process can get a SIGCHLD sent to it when 
a child process terminates.  Init maintains a list of child processes; when 
it gets a SIGCHLD, it knows that one of them dies, and restarts it.  
Obviously, this is somewhat oversimplified, but it's in general how to 
occomplish these things.

Hope this helps.  BTW, I'm pretty sure that this is coverred in a lot of 
books.  I'd start with the Stevens book (I don't remember the exact name of 
it off hand, however; something like "Unix systems programming").

-Nick

