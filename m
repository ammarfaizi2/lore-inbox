Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTB0XiC>; Thu, 27 Feb 2003 18:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTB0XiC>; Thu, 27 Feb 2003 18:38:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59665 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267222AbTB0XiA>; Thu, 27 Feb 2003 18:38:00 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: mem= option for broken bioses
Date: 27 Feb 2003 15:48:16 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b3m840$5e4$1@cesium.transmeta.com>
References: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com>
By author:    "Grover, Andrew" <andrew.grover@intel.com>
In newsgroup: linux.dev.kernel
>
> > From: Pavel Machek [mailto:pavel@ucw.cz] 
> > I've seen broken bios that did not mark acpi tables in e820
> > tables. This allows user to override it. Please apply,
> 
> OK, looks reasonable. Can you also gen up a patch documenting this in
> kernel-parameters.txt?
> 

This is very much *NOT* reasonable.  In fact, screwing around with the
syntax of the mem= parameter is poison.  I know it has already
happened, and those changes need to be reverted and the new stuff
moved to a different option.

The mem= option is unique in that it is an option that affects both
the boot loader and the kernel.  Therefore, ITS SYNTAX MUST NOT
CHANGE.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
