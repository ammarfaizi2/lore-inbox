Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275066AbTHGFOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275070AbTHGFOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:14:44 -0400
Received: from [66.212.224.118] ([66.212.224.118]:22031 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S275066AbTHGFOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:14:43 -0400
Date: Thu, 7 Aug 2003 01:02:56 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ro0tSiEgE LKML <lkml@ro0tsiege.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Soekris not exec'ing INIT
In-Reply-To: <003701c35c56$4e4dcbd0$0500000a@bp>
Message-ID: <Pine.LNX.4.53.0308070100080.9517@montezuma.mastecende.com>
References: <003701c35c56$4e4dcbd0$0500000a@bp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, Ro0tSiEgE LKML wrote:

> 
> I'm not sure that this is a specific kernel issue or not, but here goes...
> 
> I have a distro (hand compiled) running off of a CF card that's booting from
> a Soekris (Elan SC520) net4501(and net4521) with the console kernel cmdline
> set to ttyS0,19200n81, and the kernel messages show up fine and everything
> over my serial terminal, but when the kernel goes to execute /sbin/init or
> whatever I set init equal to (after the "Freeing unused kernel memory" bit),
> nothing happens, init doesn't get executed (or I cannot see it). This same
> CF card boots and runs fine from a normal PC, but from any Elan I have, init
> never gets executed. What is wrong here?

Userspace compiled for incorrect processor? One common problem is i686 
compiled binaries, you could try the following quick test (but not 100% 
conclusive)

objdump -d binary_file | grep cmov

-- 
function.linuxpower.ca
