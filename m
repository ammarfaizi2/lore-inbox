Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263953AbUDVLof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbUDVLof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 07:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbUDVLof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 07:44:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263953AbUDVLoe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 07:44:34 -0400
Date: Thu, 22 Apr 2004 07:45:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Megharaj <megharaj@isofttech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: GCC tool chain 3.3.2 problem.
In-Reply-To: <02e301c42857$f7740c60$cb00a8c0@megharaj>
Message-ID: <Pine.LNX.4.53.0404220741200.8039@chaos>
References: <02e301c42857$f7740c60$cb00a8c0@megharaj>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Megharaj wrote:

> hi,
>
> i fallowed the instruction to build the GCC tool  chain 3.3.2 given in the
> fallowing link.
>
> http://blackfin.uclinux.org/docman/view.php/18/43/Build%20instructions.doc
>
> after building i compiled the uclinux distribution with nisa-elf gcc tool
> chain it got compiled properly.
>
> but when i am compiling the same uclinux distribution with new gcc tool
> chain 3.3.2 it shows that the error header file like stddef.h are missing.
>
> if any one could give me the details abt  what is the problem with new gcc
> tool chain 3.3.2 or do i  am missing something in building the gccc tool
> chin 3.3.2.  it wud be very helpful.
>
>
> thanx n ragards
> megharaj.
>

Type exactly:

ls `gcc --print-file-name=include`/stddef.h

If you don't see the file, your tools were improperly installed.

If you do, see the file, remove `-nostdinc` on the Makefile
command-line and your compile should work.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


