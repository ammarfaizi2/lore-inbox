Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264588AbUEYL3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbUEYL3N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 07:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUEYL3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 07:29:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:48512 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264588AbUEYL3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 07:29:09 -0400
Date: Tue, 25 May 2004 07:28:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Modifying kernel so that non-root users have some root capabilities
In-Reply-To: <67B3A7DA6591BE439001F2736233351202B47E6F@xch-nw-28.nw.nos.boeing.com>
Message-ID: <Pine.LNX.4.53.0405250724490.2512@chaos>
References: <67B3A7DA6591BE439001F2736233351202B47E6F@xch-nw-28.nw.nos.boeing.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004, Laughlin, Joseph V wrote:

> (not sure if this is a duplicate or not.. Apologies in advance.)
>
> I've been tasked with modifying a 2.4 kernel so that a non-root user can
> do the following:
>
> Dynamically change the priorities of processes (up and down)
> Lock processes in memory
> Can change process cpu affinity
>
> Anyone got any ideas about how I could start doing this?  (I'm new to
> kernel development, btw.)
>
> Thanks,

You don't modify an operating system to do that!! You just make
a priviliged program (setuid) that does the things you want.

You can even transparently send the requests to your daemon so that
existing programs that expect to do such things don't need to
be modified (hint LD_PRELOAD).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


