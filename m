Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264554AbTEPSkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264555AbTEPSkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:40:24 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:8111 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264554AbTEPSjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:39:46 -0400
Date: Fri, 16 May 2003 14:13:31 -0400
From: Ben Collins <bcollins@debian.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@digeo.com>, rmk@arm.linux.org.uk,
       LKML <linux-kernel@vger.kernel.org>, davej@suse.de
Subject: Re: 2.5.69-mm5: pccard oops while booting: resolved
Message-ID: <20030516181331.GP433@phunnypharm.org>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com> <20030514191735.6fe0998c.akpm@digeo.com> <1052998601.726.1.camel@teapot.felipe-alfaro.com> <20030515130019.B30619@flint.arm.linux.org.uk> <1053004615.586.2.camel@teapot.felipe-alfaro.com> <20030515144439.A31491@flint.arm.linux.org.uk> <1053037915.569.2.camel@teapot.felipe-alfaro.com> <20030515160015.5dfea63f.akpm@digeo.com> <1053090184.653.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053090184.653.0.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. Simply by changing KOBJ_NAME_LEN from 20 to 16 fixes the problem.
> This leads me to think there are some parts of the kernel (a driver, to
> be more exact) that are corrupting memory or doing something really
> nasty that is affecting PCI ID's tables and pci_bus_match() function.

Are you sure you have a pristine source and everything is rebuilt
against the new header? It'd be very easy for one object file to have the
incorrect name len and cause this problem.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
