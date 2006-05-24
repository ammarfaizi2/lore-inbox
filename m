Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWEXWIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWEXWIo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWEXWIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:08:44 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:61864 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S964774AbWEXWIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:08:43 -0400
Date: Wed, 24 May 2006 23:08:27 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060524220827.GA12192@srcf.ucam.org>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com> <E1Fifom-0003qk-00@chiark.greenend.org.uk> <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 07:38:40PM -0400, Jon Smirl wrote:

> 2) The ROM support in the kernel knows about the shadow RAM copy at
> C000::0. When you request the ROM from a laptop video system it
> returns a map to the shadow RAM copy, not to a physical ROM. You need
> access to the shadow RAM copy to get to things the BIOS left there
> when it ran.

My experience is that, on some laptops, the code at c000:0003 may jump 
into some other address block that isn't necessarily shadowed. There's 
no reason to assume that POSTing an ancilliary ROM will work after the 
system has left the BIOS. Further, my laptop doesn't appear to have a 
rom entry in sysfs, which makes getting at stuff that way rather more 
awkward...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
