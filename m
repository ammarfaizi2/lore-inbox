Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290959AbSAaF5l>; Thu, 31 Jan 2002 00:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290953AbSAaF5c>; Thu, 31 Jan 2002 00:57:32 -0500
Received: from rj.SGI.COM ([204.94.215.100]:59041 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S290958AbSAaF5S>;
	Thu, 31 Jan 2002 00:57:18 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rob Landley <landley@trommello.org>
Cc: "World Domination Now!" <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin 
In-Reply-To: Your message of "Thu, 31 Jan 2002 00:32:40 CDT."
             <20020131053131.NGIN1833.femail28.sdc1.sfba.home.com@there> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jan 2002 16:57:10 +1100
Message-ID: <9544.1012456630@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 00:32:40 -0500, 
Rob Landley <landley@trommello.org> wrote:
>On Wednesday 30 January 2002 10:40 pm, Daniel Phillips wrote:
>> > I expect it will all get worked out eventually.  Now that the secret of
>> > the difference between maintainers and lieutenants is out.
>>
>> By the way, that never was a secret to anybody in active development.
>
>I.E. the people who knew it knew it, and hence never noticed the problem...
>
>There are, however, some people writing largeish bits of code that did not in 
>fact seem to know it.  Andre Hedrick's IDE work, Eric Raymond with the help 
>files and CML2, Kieth Owens' new build process... 

Both ESR and I definitely know about this process but kbuild is one of
the awkward systems that affects the entire kernel.  The final kbuild
system goes straight to Linus, there is nobody else to send it to.

kbuild 2.5 must match the current makefiles and config settings before
it can go in so it is impractible to target anything expect the
standard kernel, there is far too much work involved in tracking
makefile and config changes in -ac, -dj, -whoever.  Even if kbuild was
done against another tree, it would have to be redone and reverified
before sending to Linus, there is no way to extract kbuild 2.5 from a
divergent tree and expect it work on Linus's tree.

