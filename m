Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUAITWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbUAITWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:22:33 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263850AbUAITWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:22:32 -0500
Date: Fri, 9 Jan 2004 14:22:12 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PATCH 1/2: Make gotoxy & siblings use unsigned variables
In-Reply-To: <1073672901.2069.15.camel@laptop-linux>
Message-ID: <Pine.LNX.4.53.0401091415430.571@chaos>
References: <1073672901.2069.15.camel@laptop-linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Nigel Cunningham wrote:

> This patch makes console X and Y coordinates unsigned, rather than
> signed. Issues with wide (> 128 char?) consoles, seen when developing
> Software Suspend's 'nice display' are thus fixed. A brief examination of
> related code showed that this use of signed variables was the exception
> rather than the rule.
>
> Regards,
>
> Nigel
[SNIPPED...]

Question: Shouldn't we be using "size_t" for unsigned int, and
"ssize_t" for signed? If the "ints" are going to be changed,
they probably should be changed only once. As I recall, size_t
was the largest unsigned int that would fit into a register and
ssize_t was the largest signed int that would fit.

Cheers,

Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


