Return-Path: <linux-kernel-owner+w=401wt.eu-S1751737AbXAUWkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbXAUWkG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 17:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbXAUWkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 17:40:05 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:40740 "EHLO
	taverner.cs.berkeley.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbXAUWkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 17:40:04 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] Undo some of the pseudo-security madness
Date: Sun, 21 Jan 2007 22:16:17 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ep0onh$ana$1@taverner.cs.berkeley.edu>
References: <87y7nxvk65.wl@betelheise.deep.net> <1169345764.3055.935.camel@laptopd505.fenrus.org> <87tzykuj49.wl@betelheise.deep.net>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1169417777 10986 128.32.168.222 (21 Jan 2007 22:16:17 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Sun, 21 Jan 2007 22:16:17 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff  wrote:
>the core of the problem are the cores which are customarily
>dumped by lisps during the environment generation (or modification) stage,
>and then mapped back, every time the environment is invoked.
>
>at the current step of evolution, those core files are not relocatable
>in certain natively compiling lisp systems.
>
>in an even smaller subset of them, these cores are placed after
>the shared libraries and the executable.
>
>which obviously breaks when the latter are placed unpredictably.
>(yes, i know, currently mmap_base() varies over a 1MB range, but who
>says it will last indefinitely -- probably one day these people
>from full-disclosure will prevail and it will become, like, 256MB ;-)
>
>so, what do you propose?

The obvious solution is: Don't make them setuid root.
Then this issue disappears.

If there is some strong reason why they need to be setuid root, then
you'll need to explain that reason and your requirements in more detail.
But, based on your explanation so far, I have serious doubts about
whether it is a good idea to make such core-dumps setuid root in the
first place.
