Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265727AbUFOQHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265727AbUFOQHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbUFOQHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:07:20 -0400
Received: from holomorphy.com ([207.189.100.168]:39335 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265727AbUFOQHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:07:18 -0400
Date: Tue, 15 Jun 2004 09:07:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Patrick Finnegan <pat@computer-refuge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile problems on alpha: 2.6.6, 2.6.7-rc2
Message-ID: <20040615160709.GY1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Patrick Finnegan <pat@computer-refuge.org>,
	linux-kernel@vger.kernel.org
References: <200406151100.25284.pat@computer-refuge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406151100.25284.pat@computer-refuge.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 11:00:25AM -0500, Patrick Finnegan wrote:
> I'm not quite sure what's causing this, but I get the following error
> message (make V=1):
>         ld  -static -N  -T arch/alpha/kernel/vmlinux.lds.s 
> arch/alpha/kernel/head.o   init/built-in.o --start-group  usr/built-in.o  
> arch/alpha/kernel/built-in.o  arch/alpha/mm/built-in.o  
> arch/alpha/math-emu/built-in.o  kernel/built-in.o  mm/built-in.o  
> fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  
> lib/lib.a  arch/alpha/lib/lib.a  lib/built-in.o  
> arch/alpha/lib/built-in.o  drivers/built-in.o  sound/built-in.o  
> net/built-in.o --end-group  -o .tmp_vmlinux1
> local symbol 0: discarded in section `.exit.text' from drivers/built-in.o
> make then aborts at this step.  At other times, I've gotten errors that
> read the same as the above line, for symbols "1" through "4", in order.
> I'm going to guess there's a problem with one of the drivers I've got 
> built-in to the kernel, but I haven't been able to figure much else out..

Could you try to locate it with scripts/reference_discard.pl, and if that
fail, post your .config (preferably compressed) so I can try to debug this
on my alphas?

Thanks.

-- wli
