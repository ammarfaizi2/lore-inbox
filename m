Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263230AbSJHVfF>; Tue, 8 Oct 2002 17:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263231AbSJHVfF>; Tue, 8 Oct 2002 17:35:05 -0400
Received: from codepoet.org ([166.70.99.138]:53916 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S263230AbSJHVfE>;
	Tue, 8 Oct 2002 17:35:04 -0400
Date: Tue, 8 Oct 2002 15:40:44 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Kent Borg <kentborg@borg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Loading init and ld.so.1 for Coldfire V4e
Message-ID: <20021008214044.GA22488@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Kent Borg <kentborg@borg.org>, linux-kernel@vger.kernel.org
References: <20021008155415.D9391@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008155415.D9391@borg.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Oct 08, 2002 at 03:54:15PM -0400, Kent Borg wrote:
> I am trying to get Linux working on a Coldfire V4e (no, they don't
> exist yet in the outside world).  This is kind of an m68k, but being a
> Coldfire, it is a subset of the old m68k.  This is a Coldfire, but
> being new and spiffy, it has an MMU (32 instruction TLB entries, 32
> data TLB entries). 

cool.  I didn't realize there were any mmu-full Coldfire chips
in progress.  nice!

> Does anyone have a pointer to something I can read to tell me a bit of
> how programs load, what ld.so.1 does, etc?  I am in the midst of elf
> headers, I see ld.so.1 being opened, I see sections with various
> addresses flying by, and I end up trying to execute an address that is
> not executable, only read-write.  It is possible that stuff really is

I have some test stuff I use when bringing up new arches with
uClibc that can tell you if you are getting into user space
correctly.  But before messing with shared libraries, I _highly_
recommend you start with a simple staticly linked "hello world"
app for /sbin/init.  Only when that is working properly should
you begin messing with shared libs.

> percolating correctly from vma's to page tables, it is possible stuff
> really is percolating correctly from page tables to TLBs.  It is

For with bugs, nothing is impossible...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
