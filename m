Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTLDEAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 23:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbTLDEAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 23:00:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49415 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262118AbTLDEAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 23:00:07 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: partially encrypted filesystem
Date: 3 Dec 2003 19:59:47 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bqmbfj$oav$1@cesium.transmeta.com>
References: <1070485676.4855.16.camel@nucleon> <20031203214443.GA23693@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312031600460.2055@home.osdl.org> <3FCE8CF5.4030006@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3FCE8CF5.4030006@pobox.com>
By author:    Jeff Garzik <jgarzik@pobox.com>
In newsgroup: linux.dev.kernel
>
> Linus Torvalds wrote:
> > With an encrypted filesystem, you can't do that. Or rather: you can do it
> > if the filesystem is read-only, but you definitely CANNOT do it on
> > writing. For writing you have to marshall the output buffer somewhere
> > else (and quite frankly, it tends to become a lot easier if you can do
> > that for reading too).
> > 
> > And that in turn causes problems. You get all kinds of interesting
> > deadlock schenarios when write-out requires more memory in order to
> > succeed. So you need to get careful. Reading ends up being the much easier
> > case (doesn't have the same deadlock issues _and_ you could do it in-place
> > anyway).
> 
> 
> FWIW zisofs and ntfs have to do this too, since X on-disk compressed 
> pages must be expanded to X+Y in-memory pages...
> 

zisofs is read-only, so it doesn't apply.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
