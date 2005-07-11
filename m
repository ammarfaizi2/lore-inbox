Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVGKRMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVGKRMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVGKRKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:10:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25494 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262224AbVGKRJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:09:34 -0400
Date: Mon, 11 Jul 2005 19:09:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove preempt_disable from powernow-k8
Message-ID: <20050711170922.GA2502@elf.ucw.cz>
References: <Pine.LNX.4.61.0507101600560.16055@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507101600560.16055@montezuma.fsmlabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >From reading the code, my understanding is that powernow-k8 uses 
> preempt_disable to ensure that driver->target doesn't migrate across cpus 
> whilst it's accessing per processor registers, however set_cpus_allowed 
> will provide this for us. Additionally, remove schedule() calls from 
> set_cpus_allowed as set_cpus_allowed ensures that you're executing on the 
> target processor on return.

Please Cc: amd people; there should be pointer at begining of
p*n*-k8.c.

								Pavel 
-- 
teflon -- maybe it is a trademark, but it should not be.
