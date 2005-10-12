Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbVJLKIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVJLKIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 06:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVJLKIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 06:08:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5015 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751393AbVJLKIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 06:08:31 -0400
Date: Wed, 12 Oct 2005 12:07:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Felix Oxley <lkml@oxley.org>
Cc: OBATA Noboru <noboru.obata.ar@hitachi.com>, hyoshiok@miraclelinux.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
Message-ID: <20051012100730.GO12682@elf.ucw.cz>
References: <20051010084535.GA2298@elf.ucw.cz> <200510121002.59098.lkml@oxley.org> <20051012090945.GN12682@elf.ucw.cz> <200510121056.48429.lkml@oxley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510121056.48429.lkml@oxley.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 12-10-05 10:56:46, Felix Oxley wrote:
> 
> Thank you for helping a clueless newbie :-)
> 
> > Notice that suspend2 project actually introduced compression *for
> > speed*. Doing it right means that it is faster to do it
> > compressed. 
> 
> I see! 
> Little benchmarks here: http://wiki.suspend2.net/BenchMarks
> shows 15% speed _increase_ with compression.
> 
> > See Jamie Lokier's description how to *never* slow down. 
> Sorry, where is this?

Somewhere on the lkml, *long* ago. Basically idea is to have one
thread doing writing to disk, and second thread doing compression. If
no compressed pages are available, just write uncompressed ones. That
way compression can only speed things up.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
