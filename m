Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTJAEwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 00:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTJAEwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 00:52:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45581 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261901AbTJAEwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 00:52:17 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] linuxabi
Date: 30 Sep 2003 21:52:00 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bldmhg$qoa$1@cesium.transmeta.com>
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl> <E1A4WNJ-000182-00@calista.inka.de> <20031001033437.GP7665@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20031001033437.GP7665@parcelfarce.linux.theplanet.co.uk>
By author:    viro@parcelfarce.linux.theplanet.co.uk
In newsgroup: linux.dev.kernel
>
> On Wed, Oct 01, 2003 at 04:05:57AM +0200, Bernd Eckenfels wrote:
>  
> > > +#define MS_NODIRATIME  2048    /* Do not update directory access times */
> > > +#define MS_BIND                4096
> > > +#define MS_POSIXACL    (1<<16) /* VFS does not apply the umask */
> > 
> > can we clean that up? with shifting, without shifting, with comments and without comments? I suggest to use the linuxdoc comments mandatory for the abi files.
> 
> 
> ... and make it enum, while we are at it.  It's cleaner, it survives cpp
> and it can be handled by gdb et.al. in sane way.
> 
> Unless we really want to support pre-v7 compilers, there is no benefit
> in using #define for such constants.

... except you can use #ifdef to test for obsolete headers.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
