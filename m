Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbTJOMMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbTJOMMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:12:52 -0400
Received: from gprs151-179.eurotel.cz ([160.218.151.179]:53121 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262980AbTJOMMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:12:51 -0400
Date: Wed, 15 Oct 2003 14:12:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-ID: <20031015121208.GA692@elf.ucw.cz>
References: <20031014105514.GH765@holomorphy.com> <20031014045614.22ea9c4b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014045614.22ea9c4b.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > (c) mem= no longer bounds the highest physical address, but rather
> > 	the sum of memory in e820 entries post-sanitization. This
> > 	means a ZONE_NORMAL with about 384KB showed up, with duly
> > 	perverse heuristic consequences for page_alloc.c
> 
> I don't understand this.  You mean almost all memory was in ZONE_DMA?
> 
> "mem=" does not accurately emulate having that much memory.  So a 512M box
> booted with "mem=256M" has a different amount of memory from a 256M box
> booted with no "mem=" option.  It would be nice to fix that, but I've never
> looked into it.

I do not think this wants to be fixed. It should remain compatible
with 2.4.X, and if it is not that's a bug [and pretty dangerous & hard
to debug one -- if you mark something as ram which is not, you get
real bad data corruption].

									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
