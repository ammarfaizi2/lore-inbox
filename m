Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTEPRlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTEPRlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:41:14 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:22426 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264510AbTEPRlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:41:13 -0400
Date: Fri, 16 May 2003 18:55:39 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andreas Henriksson <andreas@fjortis.info>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm6
Message-ID: <20030516175539.GA16626@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andreas Henriksson <andreas@fjortis.info>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030516015407.2768b570.akpm@digeo.com> <20030516172834.GA9774@foo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516172834.GA9774@foo>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 07:28:34PM +0200, Andreas Henriksson wrote:

 > I had to remove "static" from the agp_init-function in
 > drivers/char/agp/backend.c to get the kernel to link (when building
 > Intel 810 Framebuffer into the kernel).

wrong fix. nuke the agp_init() call from i810fb
note, it still won't actually work. i810fb still fails to init
the agpgart for some reason.
 
 > I also got unresolved symbols for two modules.
 > arch/i386/kernel/suspend.ko: enable_sep_cpu, default_ldt, init_tss
 > arch/i386/kernel/apm.ko: save_processor_state, restore_processor_state

Mikael's patch for these has been posted several times already in the
last few days.

		Dave

