Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVHRQhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVHRQhf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVHRQhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:37:35 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:39697 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S932288AbVHRQhe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:37:34 -0400
To: Guillermo =?iso-8859-1?Q?L=F3pez?= Alejos <glalejos@gmail.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Environment variables inside the kernel?
References: <4fec73ca050818084467f04c31@mail.gmail.com>
From: Douglas McNaught <doug@mcnaught.org>
Date: Thu, 18 Aug 2005 12:37:14 -0400
In-Reply-To: <4fec73ca050818084467f04c31@mail.gmail.com> (Guillermo
 =?iso-8859-1?Q?L=F3pez?= Alejos's message of "Thu, 18 Aug 2005 17:44:19
 +0200")
Message-ID: <m2ek8r5hhh.fsf@Douglas-McNaughts-Powerbook.local>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillermo López Alejos <glalejos@gmail.com> writes:

> Hi,
>
> I have a piece of code which uses environment variables. I have been
> told that it is not going to work in kernel space because the concept
> of environment is not applicable inside the kernel.

Correct.

> I belive that, but I need to demonstrate it. I do not know how to
> proof this, perhaps referring to a solid reference about Linux design
> that points to the idea that it has no sense to use environment
> variables in kernel space.

Environment variables are a part of the API that Unix supplies to
userspace programs.  The kernel is not a userspace program, and as far
as I know it doesn't even do most of the work of maintaining the
environment for a process--that's done by the C library and the
userspace program loader.

> Do anyone knows about the existence of such document?

No, probably because it's such an obvious concept.  You might get hold
of one of the several books on Linux kernel programming and see if
they mention it.

If someone is insisting you use environment varaiables in kernel code,
challenge them to show you where they are implemented in the kernel.  :)

-Doug
