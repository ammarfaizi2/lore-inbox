Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTEBRT6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbTEBRT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:19:58 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38205 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263025AbTEBRT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:19:57 -0400
Date: Fri, 2 May 2003 13:32:20 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Arjan van de Ven <arjanv@redhat.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <1051895901.1593.16.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0305021325130.6565-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 May 2003, Arjan van de Ven wrote:

> > Ingo, do you want protection against shell code injection ? Have the
> > kernel to assign random stack addresses to processes and they won't be
> > able to guess the stack pointer to place the jump. I use a very simple
> > trick in my code :
> 
> stack randomisation is already present in the kernel, in the form of
> cacheline coloring for HT cpus...

we could make it even more prominent than just coloring, to introduce the
kind of variability that Davide's approach introduces. It has to be a
separate patch obviously. This would further reduce the chance that a
remote attack that has to guess the stack would succeed on a random box.

	Ingo



