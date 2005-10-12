Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVJLBDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVJLBDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 21:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVJLBDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 21:03:20 -0400
Received: from nevyn.them.org ([66.93.172.17]:4797 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751117AbVJLBDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 21:03:20 -0400
Date: Tue, 11 Oct 2005 21:03:00 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, tzachar@cs.bgu.ac.il, roland@redhat.com,
       pluto@agmk.net, linux-kernel@vger.kernel.org, jbglaw@lug-owl.de,
       vonbrand@inf.utfsm.cl
Subject: Re: - binfmt_elf-bss-padding-fix.patch removed from -mm tree
Message-ID: <20051012010300.GA8797@nevyn.them.org>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@gmail.com>,
	Andrew Morton <akpm@osdl.org>, tzachar@cs.bgu.ac.il,
	roland@redhat.com, pluto@agmk.net, linux-kernel@vger.kernel.org,
	jbglaw@lug-owl.de, vonbrand@inf.utfsm.cl
References: <200510112000.j9BK0lCF024476@shell0.pdx.osdl.net> <2cd57c900510111742i2231b785q6b60090e963b0d76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900510111742i2231b785q6b60090e963b0d76@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 08:42:31AM +0800, Coywolf Qi Hunt wrote:
> This is simply not complete. load_elf_binary() is fixed.
> load_elf_library() need to be fixed too. And theoretically
> load_elf_interp() too.

Hardly: one would require a wacky ELF interpreter to trigger, which is
your own fault, and the other is only reachable from sys_uselib and
deserves death.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
