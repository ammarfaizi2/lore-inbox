Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUDAC4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 21:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUDAC4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 21:56:50 -0500
Received: from ozlabs.org ([203.10.76.45]:36502 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262062AbUDAC4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 21:56:49 -0500
Subject: Re: [patch 1/22] Add __early_param for all arches
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040401022406.GC21709@smtp.west.cox.net>
References: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain>
	 <1080706985.29195.12.camel@bach> <20040331161305.GK13819@smtp.west.cox.net>
	 <1080784297.1999.89.camel@bach>  <20040401022406.GC21709@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1080788204.32535.122.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 01 Apr 2004 12:56:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 12:24, Tom Rini wrote:
> > > > +/* Arch code calls this early on. */
> > > > +void __init parse_early_options(const char *saved_command_line)
> > > > +{
> > > > +	static char __initdata command_line[COMMAND_LINE_SIZE];
> > > > +	strcpy(command_line, saved_command_line);

> memcpy(src, src, size) isn't good, is it?  On i386 we start out with the
> commandline in saved_command_line.  Everyone else I believe has a local
> var we point cmdline_p at, which gets copied into saved_command_line.

Read again.  Not accessing global vars at all: it's a (probably badly
named) parameter.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

