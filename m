Return-Path: <linux-kernel-owner+w=401wt.eu-S1161095AbWLUAt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWLUAt1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWLUAt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:49:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54076 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161095AbWLUAt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:49:26 -0500
Date: Wed, 20 Dec 2006 16:49:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] microcode: Fix mc_cpu_notifier section warning
Message-Id: <20061220164909.b4494851.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0612190909030.7347@ws.homenet>
References: <20061217173602.abaf4b69.khali@linux-fr.org>
	<Pine.LNX.4.61.0612180954380.3848@ws.homenet>
	<20061219083328.5951571f.khali@linux-fr.org>
	<Pine.LNX.4.61.0612190909030.7347@ws.homenet>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 09:10:25 +0000 (GMT)
Tigran Aivazian <tigran@aivazian.fsnet.co.uk> wrote:

> Hi Jean,
> 
> On Tue, 19 Dec 2006, Jean Delvare wrote:
> > I don't see anything in arch/i386/kernel/microcode.c depending on
> > CONFIG_HOTPLUG_CPU (in 2.6.20-rc1), sorry.
> 
> I run 2.6.19.1 and there both mc_cpu_notifier (which your patch modified) 
> and mc_cpu_callback (which uses mc_cpu_notifier) are inside #ifdef 
> CONFIG_HOTPLUG_CPU.

Yes, we now compile this code unconditionally and rely upon the linker to
throw it away.

Allegedly, this works.  How toolchain-version-dependent it is I don't know.
