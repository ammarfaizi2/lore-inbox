Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbTIDODe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265028AbTIDODe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:03:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59008 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264992AbTIDODc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:03:32 -0400
Date: Thu, 4 Sep 2003 10:05:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Yann Droneaud <yann.droneaud@mbda.fr>
cc: fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>,
       linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
In-Reply-To: <3F5741BD.5000401@mbda.fr>
Message-ID: <Pine.LNX.4.53.0309041001090.3367@chaos>
References: <20030904104245.GA1823@leto2.endorphin.org> <3F5741BD.5000401@mbda.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Yann Droneaud wrote:

> fruhwirth clemens wrote:
>
> > Hi!
> >
> > I recently posted a module for twofish which implements the algorithm in
> > assembler (http://marc.theaimsgroup.com/?l=linux-kernel&m=106210815132365&w=2)
> >
> > Unfortunately the assembler used is masm. I'd like to change that. Netwide
> > Assembler (nasm) is the assembler of my choice since it focuses on
> > portablity and has a more powerful macro facility (macros are heavily used
> > by 2fish_86.asm). But as I'd like to make my work useful (aim for an
> > inclusion in the kernel) I noticed that this would be the first module to
> > depend on nasm. Everything else uses gas.
> >
> > So the question is: Is a patch which depends on nasm likely to be merged?
> >
>
> I hope no ...
>
> Some years ago, we converted the only part of the kernel that used as86
> to GNU as: see arch/i386/boot. I think this was an improvement.
> Using nasm for only one small piece of code would be a regression, imho.
>
> Regards.
>
> PS: GCC pass .S assembler source files through cpp, so you get macros
> expanding.
>

GAS also has macro capability. It's just "strange". However, it
does everything MASM (/ducks/) can do. It's just strange, backwards, etc.
It takes some getting used to.

If you decide to use gcc as a preprocessor, you can't use comments,
NotGood(tm) because the "#" and some stuff after it gets "interpreted"
by cpp.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


