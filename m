Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287794AbSAXN3L>; Thu, 24 Jan 2002 08:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287804AbSAXN3A>; Thu, 24 Jan 2002 08:29:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30419 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287794AbSAXN2o>;
	Thu, 24 Jan 2002 08:28:44 -0500
Date: Thu, 24 Jan 2002 08:28:42 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre4 panics on boot )-:
In-Reply-To: <5.1.0.14.2.20020124130949.02614370@pop.cus.cam.ac.uk>
Message-ID: <Pine.GSO.4.21.0201240826320.21209-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Jan 2002, Anton Altaparmakov wrote:

> oops is below...
> 
> Can't attach .config nor decode oops at the moment as the machine is now 
> dead (I am remote), I can reboot it remotely but LILO doesn't accept my 
> remote commands (even though I send a break signal it doesn't do anything, 
> just sits at prompt and after time out boots into -pre4 and dies - any 
> ideas?). )-:
> 
> Is there a patch I can apply to fix this panic? Assuming one of the 
> scheduler ones. But which one?

In arch/i386/kernel/smpboot.c find
	global_irq_holder = 0;
and s/0/NO_PROC_ID/

