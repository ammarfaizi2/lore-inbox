Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284942AbRLFC3T>; Wed, 5 Dec 2001 21:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284943AbRLFC27>; Wed, 5 Dec 2001 21:28:59 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:43791 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284942AbRLFC2y>; Wed, 5 Dec 2001 21:28:54 -0500
Date: Wed, 5 Dec 2001 18:39:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Matthew Dobson <colpatch@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] cpus_allowed/launch_policy patch, 2.4.16
In-Reply-To: <3C0ED52E.B15F0ED7@us.ibm.com>
Message-ID: <Pine.LNX.4.40.0112051836310.1644-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Matthew Dobson wrote:

> pid_t enforce_launch_policy_fork() {
>         pid_t pp = fork();
>         if (pp == 0) {
>                 set_affinity(getpid(), get_affinity());
>                 ...
>         }
>         return pp;
> }
>
> but, as soon as one of them exec()'s their no longer going to be using your
> functions.

That's the point, cpus_allowed is automatically inherited by the child in
kernel/fork.c
So once you spawn a child with the proposed function, all its dinasty (
if it's not explicitly changed ) will have the same cpu affinity.




- Davide


