Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUE0MOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUE0MOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 08:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUE0MOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 08:14:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:30080 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261993AbUE0MOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 08:14:44 -0400
Date: Thu, 27 May 2004 08:13:54 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Zoltan.Menyhart@bull.net
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Hot plug vs. reliability
In-Reply-To: <40B5D68C.466FE969@nospam.org>
Message-ID: <Pine.LNX.4.53.0405270757250.2487@chaos>
References: <40B5D68C.466FE969@nospam.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004, Zoltan Menyhart wrote:

> I've got some questions about how hot plugging can (or cannot)
> ensure reliability:
>
> When we produce machines, we execute tests like burn in, stress,
> validation, etc. tests. In addition, every time a machine is switched
> on, a power on self test is executed.

The POST routine only verifies that some hardware "works" at the
instant it's tested. It has nothing to do with reliability.

> When we hot plug (add, remove, swap) a component that has never been
> seen, how can we make sure that the modified machine achieves the
> same MTBF as the original machine had, without passing any of the
> tests I mentioned above ?
>

If you want a highly-reliable machine of any type, the components
are normally burned-in to catch "infant mortality" problems. If
you "hot-plug" a component, that component should have undergone
the same kind of burn-in if you wish to maintain some degree
of reliability. Again a POST routine does not assure anything.
And, in fact, it's just normally initialization. If you look
at the stupid, ludicrous, "testing" done in the early IBM/PC
BIOS, you will understand that it was just some junk that
some committee decided had to be done, like moving values
around between CPU registers -- If the CPU didn't work, it
couldn't test itself -- if the CPU did work, it couldn't
test itself, etc... Just crap.

Now, memory testing has some validity because you generally
need to access it once to get all the bits into a "known"
state where the charge-pump (refresh) will keep it. However,
I doubt that much bad memory has actually been detected during
POST. It's much later, when programs or the kernel crash,
that bad memory is detected.

[SNIPPED...]

So your concern that POST hasn't been run when you hot-plug
a component isn't a problem. You cannot "test-in" reliability.
You need to design it in, test it to make sure it's been
built like it was designed, then burn it in to solve the
infant mortality problem.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


