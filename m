Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264896AbTFETBQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 15:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264899AbTFETBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 15:01:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14976 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264896AbTFETBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 15:01:15 -0400
Date: Thu, 5 Jun 2003 15:15:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Davide Libenzi <davidel@xmailserver.org>, Ed Vance <EdV@macrolink.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
In-Reply-To: <20030605183408.GB3291@matchmail.com>
Message-ID: <Pine.LNX.4.53.0306051513570.2008@chaos>
References: <11E89240C407D311958800A0C9ACF7D1A33EBD@EXCHANGE>
 <Pine.LNX.4.55.0306041717230.3655@bigblue.dev.mcafeelabs.com>
 <20030605183408.GB3291@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jun 2003, Mike Fedyk wrote:

> On Wed, Jun 04, 2003 at 05:19:05PM -0700, Davide Libenzi wrote:
> > Besides the stupid name O_REALLYNONBLOCK, it really should be different
> > from both O_NONBLOCK and O_NDELAY. Currently in Linux they both map to the
> > same value, so you really need a new value to not break binary compatibility.
>
> Hmm, wouldn't that be source and binary compatability?  If an app used
> O_NDELAY and O_NONBLOCK interchangably, then a change to O_NDELAY would
> break source compatability too.
>
> Also, what do other UNIX OSes do?  Do they have seperate semantics for
> O_NONBLOCK and O_NDELAY?  If so, then it would probably be better to change
> O_NDELAY to be similar and add another feature at the same time as reducing
> platform specific codeing in userspace.
> -

My Sun thinks that O_NDELAY = 0x04 and O_NONBLOCK = 0x80, FWIW.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

