Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbTFCKcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 06:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264955AbTFCKcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 06:32:35 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:44207 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id S264943AbTFCKcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 06:32:33 -0400
Message-ID: <3EDC7A8D.9080702@cern.ch>
Date: Tue, 03 Jun 2003 12:38:05 +0200
From: Jody Pearson <jody.pearson@cern.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Documentation / code sample wanted.
References: <Pine.LNX.4.44.0306021939490.31408-100000@lxplus077.cern.ch> <Pine.LNX.4.53.0306021409080.17768@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dick, All,

>
>This has become a FAQ, probably because people
>don't know what a kernel is. They think it's
>just some 'C' code in which you can do anything
>the 'C' compiler lets you do.
>  
>
In this case, I was being stupid with the gethostbyname exmaple. But I 
do know what a kernel is !

To fill in the blanks, I am writing a network based filesystem, and I 
now realise that the place to do the gethostbyname() is in a mount helper.

>Important! The kernel is not a 'task' it doesn't
>have a context. Everything it has been designed
>to do, is to perform systematic tasks upon behalf
>of the caller, calling from user-mode context.
>When it is executing, it is executing upon behalf
>of a user-mode task. It is doing what the user-mode
>task doesn't know how, or isn't trusted, to do.
>
What I would like to achive is a self-contained module which implements 
a filesystem. The user-space apps then interact with the fs as normal.

I am trying to avoid havng "helper daemons" for various reasons, too 
long to go into here

>
>The only thing that can call the kernel and
>successfully accomplish what it intended to do, is
>a user-mode task. Therefore, if you want to call
>the kernel, you do it from a user-mode program.
>It's just that simple.
>
And if your a filesystem ? Is it really recommended to do;

userspace->kernel->userspace->kernel->userspace ? That seems like a lot 
of context switching to me.

>
>You do this, by creating a user-mode daemon that
>sleeps in select() or poll() until the kernel code
>wakes it, 
>
[snip]

As I said, for my own reasons I would like not to have a deamon like this.

Thanks for the help.

Jody

-- 
Chaos, Panic, Pandemonium...  my work here is done.



