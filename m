Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbTIQLi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 07:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTIQLi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 07:38:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15752 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262723AbTIQLiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 07:38:25 -0400
Date: Wed, 17 Sep 2003 07:39:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ben Johnson <ben@blarg.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linear vs. logical addresses?  how does cpu interpret kernel
 addrs?
In-Reply-To: <20030916154747.A22526@blarg.net>
Message-ID: <Pine.LNX.4.53.0309170734240.881@chaos>
References: <20030916154747.A22526@blarg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Ben Johnson wrote:

> short version:
>
> 1) When I am referencing a pointer in the kernel, is the value of that
> pointer variable interpreted by the cpu as a logical or linear address?
>
> 2) if I have two overlapping data/stack segments presently selected,
> each with a different base, how does the cpu know which segment/base
> address to use to get the linear address?
>
[SNIPPED...]
All stack offsets are accessed relative to SS. No exceptions.
However a compiler may calculate those offsets based upon
something else.
This is why DS must equal SS if 'C' is going to access both
stack data variables and data segment variables. This is how
the 'C' code converter is set up. It is not a CPU limitation.
If you change the SS in the kernel, strange and wonderful
things will occur.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


