Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263586AbTD1OCG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 10:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTD1OCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 10:02:06 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28301 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263586AbTD1OCF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 10:02:05 -0400
Date: Mon, 28 Apr 2003 10:16:21 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andreas Schwab <schwab@suse.de>
cc: Mark Grosberg <mark@nolab.conman.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Combined fork-exec syscall.
In-Reply-To: <jeadea7mj3.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.53.0304281001200.16752@chaos>
References: <Pine.BSO.4.44.0304272207431.23296-100000@kwalitee.nolab.conman.org>
 <Pine.LNX.4.53.0304280855240.16444@chaos> <jed6j67o4o.fsf@sykes.suse.de>
 <Pine.LNX.4.53.0304280951500.16637@chaos> <jeadea7mj3.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Apr 2003, Andreas Schwab wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
>
> |> On Mon, 28 Apr 2003, Andreas Schwab wrote:
> |>
> |> > "Richard B. Johnson" <root@chaos.analogic.com> writes:
> |> >
> |> > |> The following is a "simple popem()', about as minimal as
> |> > |> you can get and have it work.
> |> >
> |> > Except it doesn't.
> |> >
> |> > |>     i = 0;
> |> > |>     args[i++] = "/bin/sh";
> |> > |>     args[i++] = "-c";
> |> > |>     args[i++] = strtok((char *)command, " ");
> |> > |>     for(; i< NR_ARGS; i++)
> |> > |>         if((args[i] = strtok(NULL, " ")) == NULL)
> |> > |>             break;
> |>
> |> Yes it does.
>
> $ sh -c echo a b c
>
> $ sh -c 'echo a b c'
> a b c
>
> Not what I call working.
>
> Andreas.

Read the bash documentation `man bash`. The first argument becomes
$0 (the process name), the second becomes $1, etc. Please  don't
just keep assuming that I don't know what I'm talking about.

$ sh -c 'ignore echo a b c'
Works fine.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

