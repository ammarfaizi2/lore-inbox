Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUJFAB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUJFAB6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 20:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUJFAB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 20:01:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7296 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266467AbUJEX7p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:59:45 -0400
Date: Tue, 5 Oct 2004 19:59:28 -0400 (EDT)
From: root <root@chaos.analogic.com>
To: Roland Dreier <roland@topspin.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.5-1.358 SMP
In-Reply-To: <52vfdoraly.fsf@topspin.com>
Message-ID: <Pine.LNX.4.61.0410051958100.4660@chaos.analogic.com>
References: <Pine.LNX.4.53.0410051852250.351@chaos.analogic.com>
 <52vfdoraly.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Oct 2004, Roland Dreier wrote:

>    Richard> I need to make some modules that have lots of assembly
>    Richard> code.  This assembly uses the UNIX calling convention and
>    Richard> can't be re-written (it would take many months). The new
>    Richard> kernel is compiled with "-mregparam=2". I can't find
>    Richard> where that's defined. I need to remove it because I
>    Richard> cannot pass parameters to the assembly stuff in
>    Richard> registers.
>
> You should be able to use CONFIG_REGPARM to control this.  Another
> option is just to mark the functions in your source as "asmlinkage"
> (which is defined to "__attribute__((regparm(0)))" in
> asm-i386/linkage.h).  The advantage of using asmlinkage is that your
> code will work with anyone's kernel.
>
> - Roland
>

Ahah!  I just put that in the headers that define the functions??

