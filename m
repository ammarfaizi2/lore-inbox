Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWHDAX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWHDAX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbWHDAX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:23:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:33164 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932520AbWHDAXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:23:55 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] fix dubious segment register clear in cpu_init()
Date: Fri, 4 Aug 2006 02:23:49 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44D28B6F.5030701@goop.org>
In-Reply-To: <44D28B6F.5030701@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608040223.49836.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 August 2006 01:49, Jeremy Fitzhardinge wrote:
> Fix a very dubious piece of code in
> arch/i386/kernel/cpu/common.c:cpu_init().  This clears out %fs and
> %gs, but clobbers %eax in the process without telling gcc.  It turns
> out that gcc happens to be not using %eax at that point anyway so it
> doesn't matter much, but it looks like a bomb waiting to go off.
> 
> This does end up saving an instruction, because gcc wants %eax==0 for
> the set_debugreg()s below.

Added thanks

-Andi
