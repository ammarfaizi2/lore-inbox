Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315477AbSEBX7S>; Thu, 2 May 2002 19:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315478AbSEBX7P>; Thu, 2 May 2002 19:59:15 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:2566 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315477AbSEBX6c>;
	Thu, 2 May 2002 19:58:32 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tom Oehser <tom@toms.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module choices affecting base kernel size??? 
In-Reply-To: Your message of "Thu, 02 May 2002 10:49:41 -0400."
             <Pine.LNX.4.44.0205021043200.8024-100000@conn6m.toms.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 09:58:21 +1000
Message-ID: <1427.1020383901@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002 10:49:41 -0400 (EDT), 
Tom Oehser <tom@toms.net> wrote:
>Changing all =m to =n in my config makes a 4K difference in the kernel size.
>
>But, the kernel compiled with them off still seems to load the modules fine.
>
>Why is there such a size difference in the static part and what do I risk if
>I mix a kernel compiled with the modules off with said modules?  What stuff
>is actually being compiled into the static part because of the modules I
>choose?  Doesn't it defeat the point of modules to have dependencies or even
>effects on the static part caused by the choice of module compilation?

The majority of modules have no effect on kernel size but some modules
require base kernel code as well.  This is typically common code or low
level setup functions.  You will find that those modules will not load
now or will break.

