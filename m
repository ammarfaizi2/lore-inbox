Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbUGLUsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUGLUsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUGLUsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:48:50 -0400
Received: from mail.njit.edu ([128.235.251.173]:18396 "EHLO mail-gw5.njit.edu")
	by vger.kernel.org with ESMTP id S263003AbUGLUsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:48:22 -0400
Date: Mon, 12 Jul 2004 16:48:17 -0400 (EDT)
From: rahul b jain cs student <rbj2@oak.njit.edu>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Kernel Traffic Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: printk functionality
In-Reply-To: <Pine.LNX.4.56.0407122200470.24721@jjulnx.backbone.dif.dk>
Message-ID: <Pine.GSO.4.58.0407121635580.13766@chrome.njit.edu>
References: <Pine.GSO.4.58.0407121516320.8220@chrome.njit.edu>
 <Pine.LNX.4.56.0407122200470.24721@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to collect data for a graph. For this I need to collect values of a
TCP flow. For this reason, I feel making a change in syslog.conf wont be
sufficient as I dont want the other kernel messages.

I was thinking, if I could add a new option like KERN_INFO, say
KERN_GRAPH, then I could call printk as

printk(KERN_GRAPH "data");

to collect all the required data and KERN_GRAPH would then add all this
data to a seperate file. By kernel defined files, I meant that KERN_INFO
always writes to /var/log/messages etc.

Any suggestions ??

Thanks,
Rahul.

On Mon, 12 Jul 2004, Jesper Juhl wrote:

>
> On Mon, 12 Jul 2004, rahul b jain cs student wrote:
>
> > Hi everyone,
> >
> > I want to add functionality to the printk function such that I can read
> > values off sk_buff and print them to a file specified by me rather than
> > the kernel defined files. So what I want to do is add a new option
> > like KERN_INFO.
> >
> > Does anyone know of a documentation or has ideas on how I can go about
> > doing this ?
> >
>
> I may be misunderstanding what you are trying to do, but it sounds to me
> like you would only need to edit /ets/syslog.conf and tell it to dump
> kernel messages in your own file.. Why change the kernel for this?
>
> --
> Jesper Juhl <juhl-lkml@dif.dk>
>
