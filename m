Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTD1NnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 09:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbTD1NnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 09:43:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:26253 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263579AbTD1NnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 09:43:02 -0400
Date: Mon, 28 Apr 2003 09:57:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andreas Schwab <schwab@suse.de>
cc: Mark Grosberg <mark@nolab.conman.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <jed6j67o4o.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.53.0304280951500.16637@chaos>
References: <Pine.BSO.4.44.0304272207431.23296-100000@kwalitee.nolab.conman.org>
 <Pine.LNX.4.53.0304280855240.16444@chaos> <jed6j67o4o.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Apr 2003, Andreas Schwab wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
>
> |> The following is a "simple popem()', about as minimal as
> |> you can get and have it work.
>
> Except it doesn't.
>
> |>     i = 0;
> |>     args[i++] = "/bin/sh";
> |>     args[i++] = "-c";
> |>     args[i++] = strtok((char *)command, " ");
> |>     for(; i< NR_ARGS; i++)
> |>         if((args[i] = strtok(NULL, " ")) == NULL)
> |>             break;

Yes it does.

>
> The command line must be a single argument for -c.
>

That is "implementation dependent", and not a rule. 'sh' may
take additional parameters after '-c'. In the case of Linux
which uses `bash` for `sh` this can be helpful since when
bash is envoked with ths '-c' argument, $0 becomes the next
parameter, instead if the file-name, and $1 becomes the second, etc.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

