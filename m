Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264222AbTICSWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264216AbTICSWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:22:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64384 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264127AbTICSVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:21:33 -0400
Date: Wed, 3 Sep 2003 14:23:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: James Clark <jimwclark@ntlworld.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>, rml@tech9.net,
       mochel@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
In-Reply-To: <200309031850.14925.jimwclark@ntlworld.com>
Message-ID: <Pine.LNX.4.53.0309031405340.29451@chaos>
References: <200309031850.14925.jimwclark@ntlworld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, James Clark wrote:

> Following my initial post yesterday please find attached my proposal for a
> binary 'plugin' interface:
>

But we already have a well-defined modular interface. It allows
(driver) modules to not only be installed into a running kernel,
but also to be removed from a running kernel. This makes driver
development quite easy compared to others where one needs to
re-boot to make the .... "mouse movement detected, reboot to make
the changes take effect.."

The well-defined interface for the modules is "struct file_operations".
It corresponds to the Unix I/O model for devices. This interface
is not broken and is, therefore, not necessary to be changed.

There is a Microsoft NT model where software is put somewhere and
its functions are 'registered' with the kernel. This is an abortion
designed totally to hide the inner workings of the kernel. Since
our source-code is visible, we don't need layers of abstraction
to high it from developers.

So, to your proposal, no thanks. Also, there is no way that
I will __ever__ allow software provided by others to execute
within the kernel of anything I am responsible for, unless that
software's source-code is available for inspection.

The recent problems with the Microsoft worms should certainly
convince any sane person that we can't allow some hidden software
to run our industry no matter how well we recognize the name.

There are two main reasons for using Linux in embedded systems:

(1) I know what's in there.
(2) I can make hardware drivers without having to reboot the target.

Before Linux, we had to roll our own Operating Systems. And, yes,
we made ARTOS (Analogic Realtime Operating System). We created
a whole 'C' runtime library environment. It was a bitch. We don't
need to do this anymore because there is Linux. If you, or any
other well-wisher ever succeeds in converting Linux to a binary,
no-source system, then Linux will get forked and your interface
will get fu*k^M^Mmorked also.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


