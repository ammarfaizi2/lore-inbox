Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVE3Vb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVE3Vb3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVE3Vb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:31:28 -0400
Received: from post-22.mail.nl.demon.net ([194.159.73.192]:9220 "EHLO
	post-22.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S261755AbVE3Val (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 17:30:41 -0400
Date: Mon, 30 May 2005 23:30:42 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: jayush luniya <jayu_11@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HOTPLUG CPU Support for SMT
Message-ID: <20050530213042.GA6415@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <20050530152534.21912.qmail@web32806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530152534.21912.qmail@web32806.mail.mud.yahoo.com>
Organization: M38c
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 08:25:34AM -0700, jayush luniya wrote:
> Hi,
> 
> I have been looking at the CONFIG_HOTPLUG_CPU option
> in the Linux Kernel. The option works for IA64, PPP64,
> S390 architectures. I am doing my research on SMT
> architecture and want to write a kernel module that
> can dynamically enable/disable SMT, so that I can
> switch between uniprocessor mode and SMT mode. So is
> it possible to use the CONFIG_HOTPLUG_CPU option to
> dynamically enable/disable a logical processor by
> performing a logical removal of the CPU since the
> hardware does not support CPU hotplugging? Also I
> would like to know how efficient such an
> implementation would be? 
> 
> I would really appreciate if anyone could provide me
> suggestions and any specific patches related to this
> work.

An easy way would be to use sched_setaffinity() and bind all processes
to one processor.

-- 
Rutger Nijlunsing
