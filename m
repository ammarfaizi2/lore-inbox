Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTEMScj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 14:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTEMScj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 14:32:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27405 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262423AbTEMSch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 14:32:37 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Use correct x86 reboot vector
Date: 13 May 2003 11:45:00 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9refc$qmd$1@cesium.transmeta.com>
References: <200305130851_MC3-1-38A3-A3B4@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200305130851_MC3-1-38A3-A3B4@compuserve.com>
By author:    Chuck Ebbert <76306.1226@compuserve.com>
In newsgroup: linux.dev.kernel
>
> Christer Weinigel wrote:
> 
> > BTW, what does Windows do here?  Whatever Windows is using should work
> > with Linux too.
> 
>   I've only ever seen NT4/2K do a warm reboot, if that's relevant.
> 
>   FreeBSD unmaps every page in the machine and then flushes the
> TLB as its last-resort reboot attempt.  I assume this causes a
> triplefault...
> 

So it does.  It's easier, though, to set the limit on the IDTR to zero
and then trap.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
