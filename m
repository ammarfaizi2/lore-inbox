Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVAWQ2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVAWQ2P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 11:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVAWQ2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 11:28:14 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:54662 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261323AbVAWQ2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 11:28:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=M//rHQoYLXy5ao+jR7QqCKVAfXiuuOW3l8GJp5QihX907lZ56mfHiMFSdVnYSfVVxEkUegm153uXIyMSqlzl2E7G0tfTnrMMm1D4eOgXFS9Zs1tngxKe8hQAS6nw47GiInfcy5eKUG/GZoCa1GaWb769il6r5sGzRh9+jLic7PY=
Message-ID: <5a4c581d05012308286ae9c401@mail.gmail.com>
Date: Sun, 23 Jan 2005 17:28:06 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: DVD burning still have problems
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1106496414.14219.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1106496414.14219.8.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2005 17:06:54 +0100, Kasper Sandberg <lkml@metanurb.dk> wrote:
> hello, i followed the last thread, "unable to burn DVD", and there was a
> patch, which was said to work, but it does not.. (i am running
> 2.6.11-rc1-bk9)..
> 
> the problem started around 2.6.9 (or something like it), when i was only
> able to burn 1 dvd, then i had to restart before i could burn another
> (or every second dvd i burn would fail), the error i get is input/output
> error.. my burner is working perfect, since it works on windows, and on
> 2.6.9-rcSomething.
> 
> it is not a specific place in the burning process it fails, sometimes at
> 10%, and sometimes at 97%
> 
> burning normal cd's works perfectly
> 
> now on 2.6.10 and 2.6.11-later i cant burn dvd's at all, every time i
> try to burn one, it fails, i have tried different speeds and media, same
> thing, i got a Liteon sohw1213S dvd duallayer burner, allthough im not
> using duallayer media.
> 
> here is a log from a burning i just tried:
> /dev/hda: engaging DVD-R DAO upon user request...
> /dev/hda: reserving 2149200 blocks
> /dev/hda: "Current Write Speed" is 4.1x1385KBps.
>   0.02% done, estimate finish Tue Jan 25 13:20:53 2005
>   0.05% done, estimate finish Mon Jan 24 15:13:15 2005
> <snip>
>  83.66% done, estimate finish Sun Jan 23 16:50:47 2005
>  83.68% done, estimate finish Sun Jan 23 16:50:47 2005
>  83.71% done, estimate finish Sun Jan 23 16:50:46 2005
> :-[ WRITE@LBA=1b7460h failed with SK=3h/ASC=0Ch/ACQ=00h]: Input/output
> error
> :-( write failed: Input/output error
> /dev/hda: flushing cache
> 
> this is simply what happens :(
> i have tried with and without pktcdvd loaded, same result, i hope
> someone can help me

FWIW, I happen to experience the same with the latest
 FC3 kernel on my Samsung TS-H552 burner; that is,

1. CD burning works 100% of the time
2. DVD burning may fail with EIO (nothing in kernel logs)
3. retrying burning usually works

Yes, I resorted to only use DVD+RW media now since the
 ratio of coasters has made +R more expensive than +RW :(

Last night I had to insist quite a lot with my burner's eject
 button before it decided to open and let the disc out (this
 particular session after failing once at 61% with EIO would
 reliably fail at the initial write). After reloading the tray
 with the same disc, I successfully burned it.

NB - this happens with Memorex and Verbatim media,
 not with el-cheapo discs.

I'm available for eventually testing of the 2.6.11-xx kernels
 from kernel.org (another side-effect of moving from RH9
 plus kernel.org kernels to FC3 and its own kernel is that I
 no longer have a dead machine after the updatedb run,
 which would happen about twice a month on my 256MB
 RAM k7-800).

--alessandro
 
 "And every dream, every, is just a dream after all"
  
    (Heather Nova, "Paper Cup")
