Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSLCP6w>; Tue, 3 Dec 2002 10:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSLCP6w>; Tue, 3 Dec 2002 10:58:52 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:57838 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S261847AbSLCP6w>; Tue, 3 Dec 2002 10:58:52 -0500
Subject: Re: SMP Pentium4 -- PAUSE Instruction
From: Arjan van de Ven <arjanv@redhat.com>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0212031029580.1780-100000@rtlab.med.cornell.edu>
References: <Pine.LNX.4.33L2.0212031029580.1780-100000@rtlab.med.cornell.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Dec 2002 17:06:16 +0100
Message-Id: <1038931576.20262.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-03 at 16:42, Calin A. Culianu wrote:

> Is this instruction being used in spin-wait loops?  For some reason, I am
> having a hard time figuring out whether or not it is being used.  There is
> a rep_nop() in processor.h.. but I can't determine if that is being called
> for spin lock lock/unlock code.

check cpu_relax() all over the kernel :)
and the spinlock code uses it inside it's own asm directly, not via
rep_nop()


