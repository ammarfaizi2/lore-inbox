Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271717AbTHMJUa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 05:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271755AbTHMJU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 05:20:29 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:11014 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S271717AbTHMJUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 05:20:24 -0400
Date: Wed, 13 Aug 2003 11:19:58 +0200
From: Jurriaan on adsl-gate <thunder7@xs4all.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-ID: <20030813091958.GA30746@gates.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030813045638.GA9713@middle.of.nowhere> <20030813014746.412660ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813014746.412660ae.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 01:47:46AM -0700, Andrew Morton wrote:
> Jurriaan <thunder7@xs4all.nl> wrote:
> >
> > Aug 13 06:47:48 middle -- MARK --
> >  Aug 13 06:53:03 middle kernel:  printing eip:
> >  Aug 13 06:53:03 middle kernel: c016c14a
> >  Aug 13 06:53:03 middle kernel: Oops: 0000 [#1]
> >  Aug 13 06:53:03 middle kernel: PREEMPT 
> >  Aug 13 06:53:03 middle kernel: CPU:    0
> >  Aug 13 06:53:03 middle kernel: EIP:    0060:[<c016c14a>]    Not tainted VLI
> >  Aug 13 06:53:03 middle kernel: EFLAGS: 00010286
> >  Aug 13 06:53:03 middle kernel: EIP is at find_inode_fast+0x1a/0x60
> 
> And indeed, your %edx is zero.
> 
> But if a prefetch of zero oopses then we should be oopsing in there all the
> time.
> 
> hlist_for_each() is completely assuming that prefetch(0) is safe, and you
> undoubtedly oopsed doing it.
> 
> 
> Colour me confused, and let me Cc lots of x86 guys ;)
> 
> Exactly what sort of CPU are you using?
> -
AMD Athlon XP2400+ on a VIA KT400 chipset, single CPU-system.

Kind regards,
Jurriaan
